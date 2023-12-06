package tdtu.bookstore.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import tdtu.bookstore.customenum.RoleEnum;

@Entity
@Table(name = "users")
@Data
@Setter @Getter
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "username", unique = true)
	private String username;

	@Column(name = "password")
	private String password;

	@Column(name = "phone")
	private String phone;

	@Enumerated(EnumType.STRING)
	@Column(name = "role")
	private RoleEnum role = RoleEnum.USER;
}
