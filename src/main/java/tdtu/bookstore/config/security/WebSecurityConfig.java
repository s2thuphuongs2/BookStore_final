package tdtu.bookstore.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import tdtu.bookstore.config.LoginSuccessHandler;
import tdtu.bookstore.config.filter.JWTFilter;
import tdtu.bookstore.service.impl.UserServiceImpl;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig  {
	
	@Autowired
	private LoginSuccessHandler loginSuccessHandler;
	@Autowired
	private JWTFilter jwtFilter;



	@Bean
	public DaoAuthenticationProvider getDaoAuthProvider(UserServiceImpl userService) {
	  DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
	  provider.setUserDetailsService(userService);
	  provider.setPasswordEncoder(new BCryptPasswordEncoder());
	  return provider;
	}
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http.csrf().disable()
		.authorizeHttpRequests()
		.requestMatchers("/admin", "/admin/**").hasAnyAuthority("ADMIN")
		.requestMatchers("/checkout", "/checkout/**", "/bills", "/bills/**").hasAnyAuthority("USER", "ADMIN")
		.anyRequest().permitAll()
		.and().addFilterBefore(jwtFilter, BasicAuthenticationFilter.class)
		.formLogin().loginPage("/login").successHandler(loginSuccessHandler)
		.and()
		.logout().logoutSuccessUrl("/");
		


		return http.build();
	}
}
