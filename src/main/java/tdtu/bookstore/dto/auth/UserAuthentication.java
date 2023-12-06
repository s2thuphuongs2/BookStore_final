package tdtu.bookstore.dto.auth;

import tdtu.bookstore.customenum.RoleEnum;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserAuthentication {
	private Integer userId;
	private RoleEnum role;

}
