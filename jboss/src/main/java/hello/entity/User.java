package hello.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@Entity
@Table(name = "users")
@ToString(exclude = "customers")
public class User {
	public User() {
		System.out.println("★user constracter called.");
	}

	@Id
	// usernameを主キーにする
	private String username;
	//int age;
	
	@JsonIgnore
	@Column(nullable = false,name="encoded_password")
	private String encodedPassword;
	@JsonIgnore
	// fetch
	// =FetchType.LAZYで関連エンティティを遅延ロードさせることができる（←他には？）この場合,customerフィールドにアクセスした時点で、データが読み込まれる。
	// cascade=CascadeType.ALLでUserの永続化操作や削除操作を関連先のCustomerにも伝搬させることができる。
	// 双方向の関係にする場合は、mappedByで関連先でのプロパティ名を指定する。
//	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
//	private List<Customer> customers;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEncodedPassword() {
		return encodedPassword;
	}

	public void setEncodedPassword(String encodedPassword) {
		this.encodedPassword = encodedPassword;
	}

//	public List<Customer> getCustomers() {
//		return customers;
//	}
//
//	public void setCustomers(List<Customer> customers) {
//		this.customers = customers;
//	}

}
