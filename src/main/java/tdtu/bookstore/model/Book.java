package tdtu.bookstore.model;

import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

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


@Entity
@Table(name = "books")
@Data
public class Book {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "name")
	private String name;
	
	@Column(name = "price")
	private Integer price;
	
	@Column(name = "authorid")
	private Integer authorid;
	
	@Column(name = "publisherid")
	private Integer publisherid;
	
	@Column(name = "size")
	private String size;
	
	@Column(name = "page")
	private Integer page;
	
	@Column(name = "image")
	private String image;
	
	@Column(name = "description")
	private String description;
	

    @Column(name = "category")
    private String category;
    
    @Column(name = "adddate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date adddate;
    
    @PrePersist
    private void onCreate() {
    	adddate = new Date();
    }
    
    private Integer quantity;
	
    public String getTotalPriceString() {
		return NumberFormat.getNumberInstance(Locale.US).format(this.price*this.quantity);
	}

	public String getPriceString() {
		return NumberFormat.getNumberInstance(Locale.US).format(this.price);
	}

	public String getDescriptionHTML() {
		return this.description.replaceAll("\n", "<br>");
	}
}
