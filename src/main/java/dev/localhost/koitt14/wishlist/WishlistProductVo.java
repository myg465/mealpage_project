package dev.localhost.koitt14.wishlist;

public class WishlistProductVo {
  private int seqKey;
  private int quantity;
  private int productKey;
  private int accountKey;
  private String name;
  private int price;
  private int stock;
  private String detailImageFilename1;

  public WishlistProductVo() {}

  public WishlistProductVo(int seqKey, int quantity, int productKey, int accountKey, String name, int price, int stock,
      String detailImageFilename1) {
    this.seqKey = seqKey;
    this.quantity = quantity;
    this.productKey = productKey;
    this.accountKey = accountKey;
    this.name = name;
    this.price = price;
    this.stock = stock;
    this.detailImageFilename1 = detailImageFilename1;
  }

  public int getSeqKey() {
    return seqKey;
  }

  public void setSeqKey(int seqKey) {
    this.seqKey = seqKey;
  }

  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  public int getProductKey() {
    return productKey;
  }

  public void setProductKey(int productKey) {
    this.productKey = productKey;
  }

  public int getAccountKey() {
    return accountKey;
  }

  public void setAccountKey(int accountKey) {
    this.accountKey = accountKey;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public int getPrice() {
    return price;
  }

  public void setPrice(int price) {
    this.price = price;
  }

  public int getStock() {
    return stock;
  }

  public void setStock(int stock) {
    this.stock = stock;
  }

  public String getDetailImageFilename1() {
    return detailImageFilename1;
  }

  public void setDetailImageFilename1(String detailImageFilename1) {
    this.detailImageFilename1 = detailImageFilename1;
  }
}
