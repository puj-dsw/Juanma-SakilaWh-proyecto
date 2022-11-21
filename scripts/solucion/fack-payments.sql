USE sakila_datawh;

-- Dimensions customer,staff,store,date (lines 19 to 22)
-- measure amount
-- fact table
CREATE TABLE IF NOT EXISTS fact_payments (
  customer_key INT(8) NOT NULL,
  staff_key INT(8) NOT NULL,
  store_key INT(8) NOT NULL,
  date_key INT(8) NOT NULL,
  amount DECIMAL(5,2) NOT NULL,
  payment_id INT(11) NULL DEFAULT NULL,
  INDEX fk_customer_idx (customer_key ASC) VISIBLE,
  INDEX fk_stafk_idx (staff_key ASC) VISIBLE,
  INDEX fk_store_idx (store_key ASC) VISIBLE,
  INDEX fk_date_idx (date_key ASC) VISIBLE,
  CONSTRAINT fk_customer_1
    FOREIGN KEY (customer_key)
    REFERENCES dim_customer (customer_key)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_staff_1
    FOREIGN KEY (staff_key)
    REFERENCES dim_staff (staff_key)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_store_1
    FOREIGN KEY (store_key)
    REFERENCES dim_store (store_key)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_date_1
    FOREIGN KEY (date_key)
    REFERENCES dim_date (date_key)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);