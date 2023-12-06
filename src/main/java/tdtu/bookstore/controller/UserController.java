package tdtu.bookstore.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tdtu.bookstore.model.User;
import tdtu.bookstore.repository.UserRepository;

@Controller
public class UserController {

	@Autowired
	UserRepository userRepository;

	@GetMapping("/admin/users")
	public ModelAndView viewUser() {
		ModelAndView modelAndView = new ModelAndView("admin/user/index");
		List<User> users = userRepository.findAll();

		modelAndView.addObject("users", users);

		return modelAndView;
	}


	@PostMapping("/admin/users/{userid}/edit")
	public ModelAndView editUser(@RequestParam(value = "newpassword", required = false) String newpassword,
			@PathVariable(required = true, name = "userid") Integer userid) {

		User user = userRepository.findById(userid).get();

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodedPassword = passwordEncoder.encode(newpassword);
		user.setPassword(encodedPassword);

		userRepository.save(user);

		return new ModelAndView("redirect:/admin/users");
	}
}
