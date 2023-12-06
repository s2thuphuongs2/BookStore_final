package tdtu.bookstore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tdtu.bookstore.model.Bill;

@Repository
public interface BillRepository extends JpaRepository<Bill, Integer> {
	@Query("SELECT bill FROM Bill bill WHERE userid = :userid")
	public List<Bill> findAllByUserId(Integer userid);
}