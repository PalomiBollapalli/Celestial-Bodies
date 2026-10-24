SELECT 'CREATE DATABASE universe' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'universe')\gexec
\connect universe

CREATE TABLE IF NOT EXISTS galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  galaxy_type TEXT NOT NULL,
  distance_from_earth NUMERIC NOT NULL,
  is_visible BOOLEAN NOT NULL,
  has_supermassive_black_hole BOOLEAN NOT NULL,
  stars_count BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  spectral_type TEXT NOT NULL,
  mass_solar NUMERIC NOT NULL,
  is_main_sequence BOOLEAN NOT NULL,
  has_planets BOOLEAN NOT NULL,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  age_million_years INT NOT NULL
);

CREATE TABLE IF NOT EXISTS planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  planet_type TEXT NOT NULL,
  radius_km NUMERIC NOT NULL,
  is_habitable BOOLEAN NOT NULL,
  has_rings BOOLEAN NOT NULL,
  star_id INT NOT NULL REFERENCES star(star_id),
  number_of_moons INT NOT NULL
);

CREATE TABLE IF NOT EXISTS moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  moon_type TEXT NOT NULL,
  diameter_km NUMERIC NOT NULL,
  is_geologically_active BOOLEAN NOT NULL,
  has_atmosphere BOOLEAN NOT NULL,
  planet_id INT NOT NULL REFERENCES planet(planet_id),
  discovered_year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS constellation (
  constellation_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  abbreviation VARCHAR(10) NOT NULL,
  area_square_degrees NUMERIC NOT NULL,
  is_zodiac BOOLEAN NOT NULL
);

INSERT INTO galaxy (name, galaxy_type, distance_from_earth, is_visible, has_supermassive_black_hole, stars_count) VALUES
  ('Milky Way', 'barred spiral', 0, TRUE, TRUE, 100000000000),
  ('Andromeda', 'spiral', 2537000, TRUE, TRUE, 1000000000000),
  ('Triangulum', 'spiral', 2730000, TRUE, TRUE, 40000000000),
  ('Large Magellanic Cloud', 'irregular', 163000, TRUE, TRUE, 30000000000),
  ('Small Magellanic Cloud', 'irregular', 200000, TRUE, FALSE, 3000000000),
  ('Whirlpool Galaxy', 'spiral', 23000000, TRUE, TRUE, 100000000000)
ON CONFLICT (name) DO NOTHING;

INSERT INTO star (name, spectral_type, mass_solar, is_main_sequence, has_planets, galaxy_id, age_million_years) VALUES
  ('Sun', 'G2V', 1.0, TRUE, TRUE, 1, 4600),
  ('Sirius', 'A1V', 2.06, TRUE, TRUE, 1, 242),
  ('Proxima Centauri', 'M5.5V', 0.12, TRUE, TRUE, 1, 4850),
  ('Alpha Centauri A', 'G2V', 1.1, TRUE, TRUE, 1, 5500),
  ('Betelgeuse', 'M1-M2 Ia-ab', 16.5, FALSE, FALSE, 1, 10),
  ('Vega', 'A0V', 2.1, TRUE, TRUE, 1, 455)
ON CONFLICT (name) DO NOTHING;

INSERT INTO planet (name, planet_type, radius_km, is_habitable, has_rings, star_id, number_of_moons) VALUES
  ('Mercury', 'terrestrial', 2439.7, FALSE, FALSE, 1, 0),
  ('Venus', 'terrestrial', 6051.8, FALSE, FALSE, 1, 0),
  ('Earth', 'terrestrial', 6371, TRUE, FALSE, 1, 1),
  ('Mars', 'terrestrial', 3389.5, FALSE, FALSE, 1, 2),
  ('Jupiter', 'gas giant', 69911, FALSE, TRUE, 1, 95),
  ('Saturn', 'gas giant', 58232, FALSE, TRUE, 1, 146),
  ('Uranus', 'ice giant', 25362, FALSE, TRUE, 1, 28),
  ('Neptune', 'ice giant', 24622, FALSE, TRUE, 1, 16),
  ('Proxima b', 'terrestrial', 7160, TRUE, FALSE, 3, 0),
  ('Proxima c', 'super-Earth', 9800, FALSE, FALSE, 3, 0),
  ('Sirius b-1', 'gas giant', 72000, FALSE, TRUE, 2, 2),
  ('Vega b', 'ice giant', 26000, FALSE, TRUE, 6, 3)
ON CONFLICT (name) DO NOTHING;

INSERT INTO moon (name, moon_type, diameter_km, is_geologically_active, has_atmosphere, planet_id, discovered_year) VALUES
  ('Earth Moon', 'terrestrial', 3474.8, FALSE, FALSE, 3, -1),
  ('Phobos', 'captured asteroid', 22.5, FALSE, FALSE, 4, 1877),
  ('Deimos', 'captured asteroid', 12.4, FALSE, FALSE, 4, 1877),
  ('Io', 'volcanic', 3643.2, TRUE, FALSE, 5, 1610),
  ('Europa', 'icy', 3121.6, TRUE, FALSE, 5, 1610),
  ('Ganymede', 'icy', 5268.2, TRUE, TRUE, 5, 1610),
  ('Callisto', 'icy', 4820.6, FALSE, FALSE, 5, 1610),
  ('Titan', 'icy', 5149.5, TRUE, TRUE, 6, 1655),
  ('Enceladus', 'icy', 504.2, TRUE, FALSE, 6, 1789),
  ('Rhea', 'icy', 1527.6, FALSE, FALSE, 6, 1672),
  ('Iapetus', 'icy', 1469, FALSE, FALSE, 6, 1671),
  ('Dione', 'icy', 1122.8, TRUE, FALSE, 6, 1684),
  ('Tethys', 'icy', 1062.2, FALSE, FALSE, 6, 1684),
  ('Mimas', 'icy', 396.4, FALSE, FALSE, 6, 1789),
  ('Miranda', 'icy', 471.6, TRUE, FALSE, 7, 1948),
  ('Ariel', 'icy', 1157.8, TRUE, FALSE, 7, 1851),
  ('Umbriel', 'icy', 1169.4, FALSE, FALSE, 7, 1851),
  ('Titania', 'icy', 1577.8, FALSE, FALSE, 7, 1787),
  ('Oberon', 'icy', 1522.8, FALSE, FALSE, 7, 1787),
  ('Triton', 'icy', 2706.8, TRUE, TRUE, 8, 1846)
ON CONFLICT (name) DO NOTHING;

INSERT INTO constellation (name, abbreviation, area_square_degrees, is_zodiac) VALUES
  ('Orion', 'Ori', 594, FALSE),
  ('Ursa Major', 'UMa', 1280, FALSE),
  ('Scorpius', 'Sco', 497, TRUE)
ON CONFLICT (name) DO NOTHING;
