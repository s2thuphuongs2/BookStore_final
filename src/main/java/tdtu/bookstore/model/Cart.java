package tdtu.bookstore.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Data;
import tdtu.bookstore.key.CartId;

@Entity
@Table(name = "carts")
@Data
@IdClass(CartId.class)
public class Cart {
	@Id
	@Column(name = "userid")
	private Integer userid;
	
	@Id
	@Column(name = "bookid")
	private Integer bookid;
	
	@Column(name = "quantity")
	private Integer quantity;
}

