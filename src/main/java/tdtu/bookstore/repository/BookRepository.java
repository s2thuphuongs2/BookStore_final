package tdtu.bookstore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tdtu.bookstore.model.Book;

@Repository
public interface BookRepository extends JpaRepository<Book, Integer> {

	@Query("SELECT book FROM Book book WHERE name like %:name%")
	public List<Book> findByName(String name);
	
	@Query("SELECT book from Book book WHERE find_in_set(:category,category) <> 0")
	public List<Book> findByCategory(String category);
	
	@Query("SELECT book from Book book WHERE authorid = :authorid")
	public List<Book> findByAuthor(String authorid);
	
	@Query("SELECT book from Book book WHERE publisherid = :publisherid")
	public List<Book> findByPublisher(String publisherid);
	
	@Query("SELECT book FROM Book book ORDER BY adddate DESC LIMIT 8")
	public List<Book> getLatestBooks();
	
	@Query("SELECT book FROM Book book ORDER BY RAND() LIMIT 8")
	public List<Book> getRandomBooks();
}