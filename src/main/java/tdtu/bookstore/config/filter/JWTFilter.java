package tdtu.bookstore.config.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import tdtu.bookstore.dto.auth.UserAuthentication;
import tdtu.bookstore.exception.AuthException;
import tdtu.bookstore.util.AuthUtil;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Component
public class JWTFilter extends OncePerRequestFilter {

	@Autowired
	private ObjectMapper objectMapper;

	@Value("${app.secret-key}")
	private String secretKey;

	@Override
	protected void doFilterInternal(@NonNull HttpServletRequest request, HttpServletResponse response,
									@NonNull FilterChain filterChain) throws IOException {

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			String authorization = request.getHeader(HttpHeaders.AUTHORIZATION);
			if (StringUtils.isNoneBlank(authorization)) {
				String token = authorization.replace("Bearer ", "");
				UserAuthentication user = objectMapper.convertValue(AuthUtil.getPayloadJwt(token, secretKey),
						UserAuthentication.class);
				List<SimpleGrantedAuthority> roles = new ArrayList<>();
				roles.add(new SimpleGrantedAuthority(user.getRole().toString()));
				Authentication authentication = new UsernamePasswordAuthenticationToken(user, null, roles);
				SecurityContextHolder.getContext().setAuthentication(authentication);
			}
			filterChain.doFilter(request, response);
		} catch (AuthException e) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.getWriter().write(objectMapper.writeValueAsString("Ôi không! Bạn ẩu rồi đó"));
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write(objectMapper.writeValueAsString("Ôi không! Bạn ẩu rồi đó"));
		}

	}

}
