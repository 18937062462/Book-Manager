package cn.tqs.easyui.entry;

public class TblBooksEntry {
	private int id;
	private int total;

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private String isbn;

	private String title;

	private String editionnumber;

	private String copyright;

	private Integer publisherid;

	private String imagefile;

	private Double price;

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn == null ? null : isbn.trim();
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title == null ? null : title.trim();
	}

	public String getEditionnumber() {
		return editionnumber;
	}

	public void setEditionnumber(String editionnumber) {
		this.editionnumber = editionnumber;
	}

	public String getCopyright() {
		return copyright;
	}

	public void setCopyright(String copyright) {
		this.copyright = copyright == null ? null : copyright.trim();
	}

	public Integer getPublisherid() {
		return publisherid;
	}

	public void setPublisherid(Integer publisherid) {
		this.publisherid = publisherid;
	}

	public String getImagefile() {
		return imagefile;
	}

	public void setImagefile(String imagefile) {
		this.imagefile = imagefile == null ? null : imagefile.trim();
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
}