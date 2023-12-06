package tdtu.bookstore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tdtu.bookstore.model.Cart;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {

	@Query("SELECT cart FROM Cart cart WHERE userid = :userid ORDER BY bookid")
	public List<Cart> findAllByUserId(Integer userid);
	
	@Query("SELECT cart FROM Cart cart WHERE userid = :userid and bookid = :bookid")
	public Cart findAllByUserIdAndBookid(Integer userid, Integer bookid);
}