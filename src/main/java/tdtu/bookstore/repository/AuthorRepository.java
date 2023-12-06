package tdtu.bookstore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import tdtu.bookstore.model.Author;

@Repository
public interface AuthorRepository extends JpaRepository<Author, Integer> {

}