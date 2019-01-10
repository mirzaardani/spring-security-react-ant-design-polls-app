CREATE SEQUENCE users_seq;

CREATE TABLE users (
  id bigint NOT NULL DEFAULT NEXTVAL ('users_seq'),
  name varchar(40) NOT NULL,
  username varchar(15) NOT NULL,
  email varchar(40) NOT NULL,
  password varchar(100) NOT NULL,
  created_at timestamp(0) DEFAULT NULL,
  updated_at timestamp(0) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT uk_users_username UNIQUE  (username),
  CONSTRAINT uk_users_email UNIQUE  (email)
) ;


CREATE SEQUENCE roles_seq;

CREATE TABLE roles (
  id bigint NOT NULL DEFAULT NEXTVAL ('roles_seq'),
  name varchar(60) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT uk_roles_name UNIQUE  (name)
)  ;

ALTER SEQUENCE roles_seq RESTART WITH 4;


CREATE TABLE user_roles (
  user_id bigint NOT NULL,
  role_id bigint NOT NULL,
  PRIMARY KEY (user_id,role_id)
 ,
  CONSTRAINT fk_user_roles_role_id FOREIGN KEY (role_id) REFERENCES roles (id),
  CONSTRAINT fk_user_roles_user_id FOREIGN KEY (user_id) REFERENCES users (id)
) ;

CREATE INDEX fk_user_roles_role_id ON user_roles (role_id);


CREATE SEQUENCE polls_seq;

CREATE TABLE polls (
  id bigint NOT NULL DEFAULT NEXTVAL ('polls_seq'),
  question varchar(140) NOT NULL,
  expiration_date_time timestamp(0) NOT NULL,
  created_at timestamp(0) DEFAULT NULL,
  updated_at timestamp(0) DEFAULT NULL,
  created_by bigint DEFAULT NULL,
  updated_by bigint DEFAULT NULL,
  PRIMARY KEY (id)
) ;


CREATE SEQUENCE choices_seq;

CREATE TABLE choices (
  id bigint NOT NULL DEFAULT NEXTVAL ('choices_seq'),
  text varchar(40) NOT NULL,
  poll_id bigint NOT NULL,
  PRIMARY KEY (id)
 ,
  CONSTRAINT fk_choices_poll_id FOREIGN KEY (poll_id) REFERENCES polls (id)
) ;

CREATE INDEX fk_choices_poll_id ON choices (poll_id);


CREATE SEQUENCE votes_seq;

CREATE TABLE votes (
  id bigint NOT NULL DEFAULT NEXTVAL ('votes_seq'),
  user_id bigint NOT NULL,
  poll_id bigint NOT NULL,
  choice_id bigint NOT NULL,
  created_at timestamp(0) DEFAULT NULL,
  updated_at timestamp(0) DEFAULT NULL,
  PRIMARY KEY (id)
 ,
  CONSTRAINT fk_votes_user_id FOREIGN KEY (user_id) REFERENCES users (id),
  CONSTRAINT fk_votes_poll_id FOREIGN KEY (poll_id) REFERENCES polls (id),
  CONSTRAINT fk_votes_choice_id FOREIGN KEY (choice_id) REFERENCES choices (id)
) ;

CREATE INDEX fk_votes_user_id ON votes (user_id);
CREATE INDEX fk_votes_poll_id ON votes (poll_id);
CREATE INDEX fk_votes_choice_id ON votes (choice_id);
