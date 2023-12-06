package tdtu.bookstore.model;

import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;
import tdtu.bookstore.repository.UserRepository;

@Entity
@Table(name = "bills")
@Data
public class Bill {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "userid")
	private Integer userid;

	@Column(name = "carts")
	private String carts;
	
	@Column(name = "total")
	private Integer total;
	
	@Column(name = "address")
	private String address;

	@Column(name = "phone")
	private String phone;
	
	@Column(name = "status")
	private Integer status = 0;

	@Column(name = "adddate")
	@Temporal(TemporalType.TIMESTAMP)
	private Date adddate;

	@PrePersist
	private void onCreate() {
		adddate = new Date();
	}
	
	public String getTotalPriceString() {
		return NumberFormat.getNumberInstance(Locale.US).format(this.total);
	}
}
