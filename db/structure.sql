--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: el_sockets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE el_sockets (
    id integer NOT NULL,
    user_id integer,
    code character varying,
    url character varying,
    address character varying,
    gps_lat double precision,
    gps_lng double precision,
    voltage integer,
    i_limit integer,
    "price_per_kWh" double precision,
    in_use boolean,
    "current_user" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: el_sockets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE el_sockets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: el_sockets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE el_sockets_id_seq OWNED BY el_sockets.id;


--
-- Name: relays; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE relays (
    id integer NOT NULL,
    el_socket_id integer,
    name character varying,
    pin_num integer,
    pin_id character varying,
    is_on boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: relays_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE relays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE relays_id_seq OWNED BY relays.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: socket_loads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE socket_loads (
    id integer NOT NULL,
    el_socket_id integer,
    i_current double precision,
    voltage double precision,
    power double precision,
    "time" timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: socket_loads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE socket_loads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: socket_loads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE socket_loads_id_seq OWNED BY socket_loads.id;


--
-- Name: socket_monitors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE socket_monitors (
    id integer NOT NULL,
    el_socket_id integer,
    current_sensor_id integer,
    voltage_sensor_id integer,
    nominal_voltage integer,
    active boolean,
    frequency integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: socket_monitors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE socket_monitors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: socket_monitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE socket_monitors_id_seq OWNED BY socket_monitors.id;


--
-- Name: socket_usages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE socket_usages (
    id integer NOT NULL,
    user_id integer,
    el_socket_id integer,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    "kWhs" double precision,
    amount double precision,
    date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: socket_usages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE socket_usages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: socket_usages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE socket_usages_id_seq OWNED BY socket_usages.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying,
    last_usage integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY el_sockets ALTER COLUMN id SET DEFAULT nextval('el_sockets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY relays ALTER COLUMN id SET DEFAULT nextval('relays_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_loads ALTER COLUMN id SET DEFAULT nextval('socket_loads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_monitors ALTER COLUMN id SET DEFAULT nextval('socket_monitors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_usages ALTER COLUMN id SET DEFAULT nextval('socket_usages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: el_sockets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY el_sockets
    ADD CONSTRAINT el_sockets_pkey PRIMARY KEY (id);


--
-- Name: relays_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relays
    ADD CONSTRAINT relays_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: socket_loads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_loads
    ADD CONSTRAINT socket_loads_pkey PRIMARY KEY (id);


--
-- Name: socket_monitors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_monitors
    ADD CONSTRAINT socket_monitors_pkey PRIMARY KEY (id);


--
-- Name: socket_usages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_usages
    ADD CONSTRAINT socket_usages_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_el_sockets_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_el_sockets_on_user_id ON el_sockets USING btree (user_id);


--
-- Name: index_relays_on_el_socket_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_relays_on_el_socket_id ON relays USING btree (el_socket_id);


--
-- Name: index_socket_loads_on_el_socket_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_socket_loads_on_el_socket_id ON socket_loads USING btree (el_socket_id);


--
-- Name: index_socket_monitors_on_el_socket_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_socket_monitors_on_el_socket_id ON socket_monitors USING btree (el_socket_id);


--
-- Name: index_socket_usages_on_el_socket_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_socket_usages_on_el_socket_id ON socket_usages USING btree (el_socket_id);


--
-- Name: index_socket_usages_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_socket_usages_on_user_id ON socket_usages USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: fk_rails_0232857c19; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_usages
    ADD CONSTRAINT fk_rails_0232857c19 FOREIGN KEY (el_socket_id) REFERENCES el_sockets(id);


--
-- Name: fk_rails_38f7a13354; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_loads
    ADD CONSTRAINT fk_rails_38f7a13354 FOREIGN KEY (el_socket_id) REFERENCES el_sockets(id);


--
-- Name: fk_rails_3acf41b1d8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_monitors
    ADD CONSTRAINT fk_rails_3acf41b1d8 FOREIGN KEY (el_socket_id) REFERENCES el_sockets(id);


--
-- Name: fk_rails_bb06cdaca6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relays
    ADD CONSTRAINT fk_rails_bb06cdaca6 FOREIGN KEY (el_socket_id) REFERENCES el_sockets(id);


--
-- Name: fk_rails_bcccede375; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY socket_usages
    ADD CONSTRAINT fk_rails_bcccede375 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_d02d8d81fe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY el_sockets
    ADD CONSTRAINT fk_rails_d02d8d81fe FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170411140425'),
('20170411140427'),
('20170520185737'),
('20170521202050'),
('20170522130400'),
('20170522130450'),
('20170522130532'),
('20170522130555'),
('20170524100614'),
('20170524102451'),
('20170524111142'),
('20170524134517'),
('20170529182710');


