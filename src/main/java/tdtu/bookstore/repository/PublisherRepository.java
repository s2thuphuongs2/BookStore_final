package tdtu.bookstore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import tdtu.bookstore.model.Publisher;

@Repository
public interface PublisherRepository extends JpaRepository<Publisher, Integer> {

}