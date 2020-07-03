package dev.localhost.koitt14.cart;

public class CartVo {
  private int seqKey;
  private int quantity;
  private int productKey;
  private int accountKey;

  public CartVo() {}

  public CartVo(int seqKey, int quantity, int productKey, int accountKey) {
    this.seqKey = seqKey;
    this.quantity = quantity;
    this.productKey = productKey;
    this.accountKey = accountKey;
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
}
