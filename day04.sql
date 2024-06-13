create user c##kosta identified by kosta;
grant connect, resource, dba to c##kosta;

CREATE TABLE customer (
       customer_id          NUMBER NOT NULL,
       customer_name        VARCHAR2(20) NULL,
       b_number             VARCHAR2(20) NULL
);


ALTER TABLE customer
       ADD  ( PRIMARY KEY (customer_id) ) ;
       
CREATE TABLE orders (
       order_id             NUMBER NOT NULL,
       order_date           DATE NULL,
       total_price          NUMBER NULL,
       order_state          VARCHAR(20) NULL,
       customer_id          NUMBER NOT NULL
);

ALTER TABLE orders
       ADD  ( PRIMARY KEY (order_id) ) ;
       
ALTER TABLE orders
       ADD  ( FOREIGN KEY (customer_id)
                             REFERENCES customer ) ;

CREATE TABLE orderDetail (
       order_count          NUMBER NULL,
       order_price          NUMBER NULL,
       product_id           NUMBER NOT NULL,
       order_id             NUMBER NOT NULL
);


ALTER TABLE orderDetail
       ADD  ( PRIMARY KEY (product_id, order_id) ) ;
    

ALTER TABLE orderDetail
       ADD  ( FOREIGN KEY (order_id)
                             REFERENCES orders ) ;
ALTER TABLE orderDetail
       ADD  ( FOREIGN KEY (product_id)
                             REFERENCES product ) ;

CREATE TABLE product (
       product_id           NUMBER NOT NULL,
       product_name         VARCHAR2(20) NULL,
       product_price        NUMBER NULL
);

ALTER TABLE product
       ADD  ( PRIMARY KEY (product_id) ) ;
                     
                             
desc customer;
desc product;
desc orders;
desc orderDetail;

drop table orderDetail;
drop table orders;
drop table product;
drop table customer;