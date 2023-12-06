package tdtu.bookstore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tdtu.bookstore.model.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
	
	@Query("SELECT category FROM Category category ORDER BY RAND() LIMIT 8")
	public List<Category> getRandomCategories();
}