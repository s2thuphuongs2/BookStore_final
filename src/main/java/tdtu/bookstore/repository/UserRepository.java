package tdtu.bookstore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tdtu.bookstore.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

	@Query("SELECT user FROM User user WHERE username like :username")
	public User findByUsername(String username);

	@Query("SELECT user FROM User user WHERE phone like :phoneNumber")
	User findFirstByPhoneNumber(String phoneNumber);
}