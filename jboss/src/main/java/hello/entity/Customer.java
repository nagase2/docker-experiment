package hello.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "customers")
// テーブル名（＝クラス名）
@Data
// JPAの仕様で、EntityClassには引数のないデフォルトコンストラクタを作る必要がある。
@AllArgsConstructor
public class Customer {
	
@Id
 // @GeneratedValue(strategy = GenerationType.AUTO)
  // 主キーがDBで自動裁判されることをこのアノテーションで示す
  private Integer id;
  @Column(nullable = false,name="first_name")
  // このカラムの制約事項を指定
  private String firstName;
  @Column(nullable = false,name="last_name")
  private String lastName;
  
//  @ManyToOne(fetch = FetchType.EAGER)
 // @JsonIgnore
  @ManyToOne(fetch = FetchType.LAZY) //これをOnにするとRESTでコケる
  // UserとCustomerを多対一の関係にする。
  @NotFound(action = NotFoundAction.IGNORE)
  @JoinColumn(nullable = true, name = "username")
  // Joincolumnで外部キーのカラム名を指定
  private User user;
  
  public Customer(){
	  System.out.println("★customer entity constractor");
  }

  public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
}
