package tdtu.bookstore.service.impl;

import tdtu.bookstore.service.AuthService;
import tdtu.bookstore.repository.UserRepository;

import tdtu.bookstore.customenum.RoleEnum;
import tdtu.bookstore.dto.auth.UserAuthentication;
import tdtu.bookstore.dto.auth.output.LoginOutput;
import tdtu.bookstore.model.User;
import tdtu.bookstore.util.AuthUtil;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private ObjectMapper objectMapper;

	@Value("${app.secret-key}")
	private String secretKey;

	@Override
	public String login(User input) {
		// Kiểm tra username có tồn tại chưa
		String username = input.getUsername();
		User existedUser = userRepository.findByUsername(username);
		if (existedUser == null) {
			return "NOT_EXISTED_USERNAME";
		}
		// Mã hóa mật khẩu
		String presentPassword = AuthUtil.encodedPassword(input.getPassword());
		String savedPassword = existedUser.getPassword();
		if (!presentPassword.equals(savedPassword)) {
			return "INCORRECT_PASSWORD";
		}
		// Generate jwt(json web token) and return
		UserAuthentication userAuthentication = new UserAuthentication();
		userAuthentication.setUserId(existedUser.getId());
		userAuthentication.setRole(existedUser.getRole());
		Map<String, Object> payload = objectMapper.convertValue(userAuthentication, new TypeReference<>() {
		});
		LoginOutput output = new LoginOutput();
		output.setUserId(existedUser.getId());
		output.setToken(AuthUtil.generateToken(payload, secretKey));
		return "LOGIN_SUCCESS";
	}

	@Override
	public String signUp(User input) {
		// Kiểm tra username có tồn tại chưa
		String username = input.getUsername();
		User existedUsername = userRepository.findByUsername(username);
		if (existedUsername != null) {
			return "EXISTED_USERNAME";
		}
		// Kiểm tra phone có tồn tại chưa
		String phoneNumber = input.getPhone();
		User existedPhoneNumber = userRepository.findFirstByPhoneNumber(phoneNumber);
		if (existedPhoneNumber != null) {
			return "EXISTED_PHONE_NUMBER";
		}
		input.setRole(RoleEnum.USER);
		// Mã hóa mật khẩu
		input.setPassword(AuthUtil.encodedPassword(input.getPassword()));

		userRepository.save(input);

		return "REGISTER_SUCCESS";
	}
}
