# Write methods that return SQL queries for each part of the challeng here

def guest_with_most_appearances
  "SELECT *
  FROM famous_people
  INNER JOIN show
  ON famous_people.id = show.famous_people_id
  GROUP BY famous_people.id
  ORDER BY count(show.famous_people_id) DESC LIMIT 1
  "
end

def most_common_profession_each_year#broken (returns multiple professions)
  "SELECT famous_people.job, show.year
  FROM famous_people
JOIN show
ON famous_people.id = show.famous_people_id
GROUP BY famous_people.job
ORDER BY count(famous_people.job)"
end

def most_common_profession
    "SELECT famous_people.job
  FROM famous_people
  GROUP BY famous_people.job
   ORDER BY count(famous_people.job) DESC LIMIT 1"
end

def first_name_bill
  " SELECT count(famous_people.guest)
FROM famous_people
WHERE famous_people.guest LIKE '%bill%' "
end

def patrick_stewart_dates
  "SELECT show.date
FROM famous_people
INNER JOIN show
ON famous_people.id = show.famous_people_id
WHERE famous_people.guest = 'Patrick Stewart'"
end

def year_with_most_guests
  "SELECT show.year
FROM famous_people
INNER JOIN show
ON famous_people.id = show.famous_people_id
GROUP BY show.year
ORDER BY count(famous_people.id) DESC LIMIT 1"
end

def most_popular_topic_by_year
  "SELECT show.topic,show.year
  FROM show
GROUP BY show.year
ORDER BY count(show.topic) DESC"
end
