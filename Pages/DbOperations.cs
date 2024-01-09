using System.Data.Common;
using System.Runtime.CompilerServices;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc.Formatters;
using MySql.Data.MySqlClient;
using Org.BouncyCastle.Asn1.X509;

namespace pdftest.Pages
{
    public static class DbOperations
    {
        static string schoolCon = "Data source=DESKTOP-S5QTT0P; Database=PdfTests; User=User1; Pwd=admin";
        static string kalinCon = "Data source=DESKTOP-GQNFF8F; Database=PdfTests; User=User1; Pwd=admin";
        static string mishoCon = "Data source=DESKTOP-BIJEL7I; Database=PdfTests; User=User1; Pwd=admin";
        static string mishoCon2 = "Data source=localhost; Database=PdfTests; User=root; Pwd=admin";
        static string[] conStrings = { schoolCon, kalinCon, mishoCon, mishoCon2 };
        public static string connection = conStrings[3];

        public static int GetGeneratedTestsCount()
        {
            int testsCount = 0;

            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select generatedTests from TestStatistics";
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        testsCount = rdr.GetInt32(0);
                    }
                    rdr.Close();
                }
            }
            con.Close();
            return testsCount;
        }
        public static int GetQuestionsCount()
        {
            int questionsCount = 0;

            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select questionscount from TestStatistics";
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        questionsCount = rdr.GetInt32(0);
                    }
                    rdr.Close();
                }
            }
            con.Close();
            return questionsCount;
        }
        public static int GetSpecialitiesCount()
        {
            int specialitiesCount = 0;

            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select count(id) from Specialities";
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        specialitiesCount = rdr.GetInt32(0);
                    }
                    rdr.Close();
                }
            }
            con.Close();
            return specialitiesCount;
        }
        public static List<User> GetAllUserData()
        {
            List<User> users = new List<User>();
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select a.id, a.firstname, a.lastname, a.email, sp.specialityName, a.isadmin, s.schoolName from accounts as a inner join schools as s on a.school = s.id inner join specialities as sp on a.speciality = sp.id;";
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        User user = new User();
                        user.Id = rdr.GetInt32("id");
                        user.FirstName = rdr.GetString("firstname");
                        user.LastName = rdr.GetString("lastname");
                        user.Email = rdr.GetString("email");
                        user.Speciality = rdr.GetString("specialityName");
                        user.School = rdr.GetString("schoolName");
                        user.IsAdmin = rdr.GetString("isadmin");
                        users.Add(user);
                    }
                    rdr.Close();
                }
            }
            con.Close();
            return users;
        }
        public static List<string> GetSchools()
        {
            List<string> schools = new List<string>();
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select schoolname from schools order by schoolname ASC;";
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        schools.Add(rdr.GetString(0));
                    }
                }
                rdr.Close();
            }
            con.Close();
            return schools;
        }
        public static List<string> GetSpecialities()
        {
            List<string> specialities = new List<string>();
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select specialityName from specialities order by specialityName ASC;";
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        specialities.Add(rdr.GetString(0));
                    }
                }
                rdr.Close();
            }
            con.Close();
            return specialities;
        }
        public static User GetUserById(int id)
        {
            User user = new User();
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select a.id, a.firstname, a.lastname, a.email, a.password, s.schoolName, sp.specialityName, a.isadmin from accounts as a inner join specialities as sp on a.speciality = sp.id inner join schools as s on a.school = s.id where a.id = @id;";
                cmd.Parameters.AddWithValue("id", id);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        user.Id = rdr.GetInt32("id");
                        user.FirstName = rdr.GetString("firstname");
                        user.LastName = rdr.GetString("lastname");
                        user.Email = rdr.GetString("email");
                        byte[] decryptedPass = System.Convert.FromBase64String(rdr.GetString("password"));
                        user.Password = System.Text.Encoding.UTF8.GetString(decryptedPass);
                        user.School = rdr.GetString("schoolName");
                        user.Speciality = rdr.GetString("specialityName");
                        user.IsAdmin = rdr.GetString("isadmin");
                    }
                }
                rdr.Close();
            }
            con.Close();
            return user;
        }
        public static void CreateNewUser(string firstname, string lastname, string email, string password, string school, string speciality, bool isadmin)
        {
            int schoolId = 0;
            int specialityId = 0;

            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select id from schools where schoolName = @school;";
                cmd.Parameters.AddWithValue("school", school);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        schoolId = rdr.GetInt32(0);
                    }
                    rdr.Close();
                }

                cmd.CommandText = "Select id from specialities where specialityName = @speciality";
                cmd.Parameters.AddWithValue("speciality", speciality);
                rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        specialityId = rdr.GetInt32(0);
                    }
                    rdr.Close();
                }

                try
                {
                    byte[] passwordBytes = System.Text.Encoding.UTF8.GetBytes(password);
                    password = System.Convert.ToBase64String(passwordBytes);

                    cmd.CommandText = "Insert into accounts(firstname, lastname, email, password, speciality, isadmin, school) values(@firstname, @lastname, @email, @password, @specialityId, @isadmin, @schoolId);";
                    cmd.Parameters.AddWithValue("firstname", firstname);
                    cmd.Parameters.AddWithValue("lastname", lastname);
                    cmd.Parameters.AddWithValue("email", email);
                    cmd.Parameters.AddWithValue("password", password);
                    cmd.Parameters.AddWithValue("specialityId", specialityId);
                    cmd.Parameters.AddWithValue("isadmin", isadmin);
                    cmd.Parameters.AddWithValue("schoolId", schoolId);
                    cmd.ExecuteNonQuery();
                }
                catch (MySqlException ex)
                {
                    Console.WriteLine(ex.Message);
                }

            }
            con.Close();
        }
        public static void DeleteUser(int id)
        {
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Delete from accounts where id = @id;";
                cmd.Parameters.AddWithValue("id", id);
                cmd.ExecuteNonQuery();
            }
            con.Close();
        }
        public static void UpdateUser(string id, string firstname, string lastname, string email, string password, string school, string speciality, bool isadmin)
        {
            int schoolId = 0;
            int specialityId = 0;

            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select id from schools where schoolName = @school;";
                cmd.Parameters.AddWithValue("school", school);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        schoolId = rdr.GetInt32(0);
                    }
                    rdr.Close();
                }

                cmd.CommandText = "Select id from specialities where specialityName = @speciality";
                cmd.Parameters.AddWithValue("speciality", speciality);
                rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        specialityId = rdr.GetInt32(0);
                    }
                    rdr.Close();
                }

                try
                {
                    cmd.CommandText = "Update accounts set firstname=@firstname, lastname=@lastname, email=@email, password=@password, speciality=@specialityId, isadmin=@isadmin, school=@schoolId where id=@id;";
                    cmd.Parameters.AddWithValue("id", id);
                    cmd.Parameters.AddWithValue("firstname", firstname);
                    cmd.Parameters.AddWithValue("lastname", lastname);
                    cmd.Parameters.AddWithValue("email", email);
                    byte[] newPasswordBytes = System.Text.Encoding.UTF8.GetBytes(password);
                    cmd.Parameters.AddWithValue("password", System.Convert.ToBase64String(newPasswordBytes)); 
                    cmd.Parameters.AddWithValue("specialityId", specialityId);
                    cmd.Parameters.AddWithValue("isadmin", isadmin);
                    cmd.Parameters.AddWithValue("schoolId", schoolId);
                    cmd.ExecuteNonQuery();
                }
                catch (MySqlException ex)
                {
                    Console.WriteLine(ex.Message);
                }

            }
            con.Close();
        }
        public static void AddNewQuestion(string speciality, int ticket, string category, 
            string questionText1, string questionText2, 
            string answerA1, string answerB1, string answerC1, string answerD1, 
            string answerA2, string answerB2, string answerC2, string answerD2,
            bool correctAnswerA1, bool correctAnswerB1, bool correctAnswerC1, bool correctAnswerD1,
            bool correctAnswerA2, bool correctAnswerB2, bool correctAnswerC2, bool correctAnswerD2,
            string openAnswer1, string openAnswer2,
            int points, int school)
        {
            string questionCategory = $"{GetSpecialityId(speciality)}_{ticket}_{category}"; //Дефинираме предварително променлива за категорията в MySQL БД, която приема стойност (ID на специалността_билет_категория) и за това използваме функцията да се вземе ID-то на специалността, вместо името ѝ

            List<int> correctAnswers1 = new List<int>();
            List<int> correctAnswers2 = new List<int>();
            if(openAnswer1 == null)
            {
                bool[] answers1 = { correctAnswerA1, correctAnswerB1, correctAnswerC1, correctAnswerD1 };
                bool[] answers2 = { correctAnswerA2, correctAnswerB2, correctAnswerC2, correctAnswerD2 };


                for(int i = 0; i < answers1.Length; i++)
                {
                    if(answers1[i]) correctAnswers1.Add(i + 1);
                }
                for(int i = 0; i < answers2.Length; i++)
                {
                    if(answers2[i]) correctAnswers2.Add(i + 1);
                }
            }

            //Изпращаме и двата варианта на въпроса по същото време с един С# метод. Имаме 2 параметъра questionText1 за вариант 1 и questionText2 за вариант 2. Същото и за затворените отговори ако има такива. AnswerA1 = отговор А от вариант 1

            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand(); //Заявка за първи вариант на въпроса
                cmd.CommandText = "Insert into questions(speciality, ticket, questionCategory, questionVar, questionText, answerA, answerB, answerC, answerD, points, school, correctAnswer) values(@speciality, @ticket, @questionCategory, 1, @questionText1, @answerA1, @answerB1, @answerC1, @answerD1, @points, @school, @correctAnswer);";
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@questionCategory", questionCategory);
                cmd.Parameters.AddWithValue("speciality", speciality);
                cmd.Parameters.AddWithValue("ticket", ticket);
                cmd.Parameters.AddWithValue("questionText1", questionText1);
                cmd.Parameters.AddWithValue("answerA1", answerA1);
                cmd.Parameters.AddWithValue("answerB1", answerB1);
                cmd.Parameters.AddWithValue("answerC1", answerC1);
                cmd.Parameters.AddWithValue("answerD1", answerD1);
                cmd.Parameters.AddWithValue("points", points);
                cmd.Parameters.AddWithValue("@school", school);
                if(openAnswer1 != null) cmd.Parameters.AddWithValue("@correctAnswer", openAnswer1);
                else cmd.Parameters.AddWithValue("@correctAnswer", string.Join(',', correctAnswers1));
                cmd.ExecuteNonQuery();

                MySqlCommand cmd2 = new MySqlCommand(); //Заявка за втори вариант на въпроса
                cmd2.Connection = con;
                cmd2.CommandText = "Insert into questions(speciality, ticket, questionCategory, questionVar, questionText, answerA, answerB, answerC, answerD, points, school, correctAnswer) values(@speciality, @ticket, @questionCategory, 2, @questionText2, @answerA2, @answerB2, @answerC2, @answerD2, @points, @school, @correctAnswer);";
                cmd2.Parameters.AddWithValue("@questionCategory", questionCategory);
                cmd2.Parameters.AddWithValue("speciality", speciality);
                cmd2.Parameters.AddWithValue("ticket", ticket);
                cmd2.Parameters.AddWithValue("questionText2", questionText2);
                cmd2.Parameters.AddWithValue("answerA2", answerA2);
                cmd2.Parameters.AddWithValue("answerB2", answerB2);
                cmd2.Parameters.AddWithValue("answerC2", answerC2);
                cmd2.Parameters.AddWithValue("answerD2", answerD2);
                cmd2.Parameters.AddWithValue("points", points);
                cmd2.Parameters.AddWithValue("school", school);
                if (openAnswer2 != null) cmd2.Parameters.AddWithValue("@correctAnswer", openAnswer2);
                else cmd2.Parameters.AddWithValue("@correctAnswer", string.Join(',', correctAnswers2));
                cmd2.ExecuteNonQuery();
            }
            con.Close();
        }
        public static List<Questions> GetAllQuestions(string speciality, int ticket, int category, int school)
        {
            List<Questions> questionsList = new List<Questions>();
            int specialityId = GetSpecialityId(speciality);
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select id, questionVar, questionText, answerA, answerB, answerC, answerD, points from questions where questionCategory = @category and school = @school";
                cmd.Parameters.AddWithValue("category", $"{specialityId}_{ticket}_{category}");
                cmd.Parameters.AddWithValue("school", school);
                MySqlDataReader rdr = cmd.ExecuteReader();

                using (rdr)
                {
                    while (rdr.Read())
                    {
                        Questions questions = new Questions();
                        questions.Id = rdr.GetInt32("id");
                        questions.QuestionVar = rdr.GetInt32("questionVar");
                        questions.QuestionText = rdr.GetString("questionText");
                        questions.AnswerA = rdr.IsDBNull(rdr.GetOrdinal("answerA")) ? null : rdr.GetString("answerA"); //Това го правим, защото ако стойността е празна за отговорите (т.е. въпросът е с отворен отговор) дава грешка. За целта проверяваме дали е null.
                        questions.AnswerB = rdr.IsDBNull(rdr.GetOrdinal("answerB")) ? null : rdr.GetString("answerB");
                        questions.AnswerC = rdr.IsDBNull(rdr.GetOrdinal("answerC")) ? null : rdr.GetString("answerC");
                        questions.AnswerD = rdr.IsDBNull(rdr.GetOrdinal("answerD")) ? null : rdr.GetString("answerD");
                        questions.Points = rdr.GetInt32("points");
                        questionsList.Add(questions);
                    }
                    rdr.Close();
                }
            }
            con.Close();
            return questionsList;
        }
        public static int GetSpecialityId(string speciality)
        {
            int id = 0;
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select id from specialities where specialityName = @speciality";
                cmd.Parameters.AddWithValue("speciality", speciality);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        id = rdr.GetInt32(0);
                    }
                }
                rdr.Close();
            }
            con.Close();
            return id;
        }
        public static int GetCategoriesCount(string speciality, int ticket)
        {
            int catCount = 0;
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select count(distinct(questionCategory)) from questions where speciality = @speciality and ticket = @ticket and questionVar = 1;";
                cmd.Parameters.AddWithValue("speciality", speciality);
                cmd.Parameters.AddWithValue("ticket", ticket);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        catCount = rdr.GetInt32(0);
                    }
                }
                rdr.Close();
            }
            con.Close();
            return catCount;
        }
        public static string GetCategoryDescription(string catNum)
        {
            string catDescription = "";
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand("Select categoryText from categories where questionCategory = @catNum", con);
                cmd.Parameters.AddWithValue("@catNum", catNum);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        catDescription = rdr.GetString(0);
                    }
                }
                rdr.Close();
            }
            con.Close();
            return catDescription;
        }
        public static int GetCategoryPoints(string catNum) //Връща колко точки трябва да има дадена категория
        {
            int points = 0;
            MySqlConnection con = new MySqlConnection(connection);
            using (con)
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select points from categories where questionCategory = @catnum";
                cmd.Parameters.AddWithValue("@catnum", catNum);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        points = rdr.GetInt32(0);
                    }
                }
                rdr.Close();
            }
            con.Close();
            return points;
        }
        public static Questions GetQuestionById(int id)
        {
            Questions question = new Questions();

            string questionText = "";
            MySqlConnection con = new MySqlConnection(connection);
            using (con)
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select questionText, answerA, answerB, answerC, answerD, points from questions where id=@id;";
                cmd.Parameters.AddWithValue("@id", id);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        question.QuestionText = rdr.GetString(0);
                        question.AnswerA = rdr.IsDBNull(rdr.GetOrdinal("answerA")) ? null : rdr.GetString("answerA");
                        question.AnswerB = rdr.IsDBNull(rdr.GetOrdinal("answerB")) ? null : rdr.GetString("answerB");
                        question.AnswerC = rdr.IsDBNull(rdr.GetOrdinal("answerC")) ? null : rdr.GetString("answerC");
                        question.AnswerD = rdr.IsDBNull(rdr.GetOrdinal("answerD")) ? null : rdr.GetString("answerD");
                        question.Points = rdr.GetInt32(5);
                    }
                    rdr.Close();
                }
            }
            con.Close();
            return question;
        }
        public static string GetTicketDescription(int specialityCode, int ticketNum)
        {
            string ticketDescription = "";
            string id = specialityCode + "_" + ticketNum;
            Console.WriteLine(id);
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select ticketDescription from tickets where ticketid = @id;";
                cmd.Parameters.AddWithValue("@id", id);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        Console.WriteLine(rdr.GetValue(0));
                        ticketDescription = rdr.GetString(0);
                        Console.WriteLine("ticketdesc = " + ticketDescription);
                    }
                    rdr.Close();
                }
            }
            con.Close();
            return ticketDescription;
        }

        public static void AddCategory(string categoryText, int specialityNum, int ticket, int categoryNum, int points)
        {
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = $"Insert into categories (questionCategory, categoryNum, categoryText, points) values (@questionCategory, @categoryNum, @categoryText, @points);";
                cmd.Parameters.AddWithValue("@questionCategory", $"{specialityNum}_{ticket}_{categoryNum}");
                cmd.Parameters.AddWithValue("@categoryNum", categoryNum);
                cmd.Parameters.AddWithValue("@categoryText", categoryText);
                cmd.Parameters.AddWithValue("@points", points);
                cmd.ExecuteNonQuery();
            }
            con.Close();
        }

        public static void AddSpeciality(string speciality) 
        {
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Insert into specialities (specialityName) values (@speciality);";
                cmd.Parameters.AddWithValue("@speciality", speciality);
                cmd.ExecuteNonQuery();
            }
            con.Close();
        }
        public static string GetPasswordByEmail(string email)
        {
            string password = "";
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Select password from accounts where email = @email;";
                cmd.Parameters.AddWithValue("@email", email);
                MySqlDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    while (rdr.Read())
                    {
                        password = rdr.GetString(0);
                    }
                    rdr.Close();
                }
            }
            con.Close();
            byte[] decryptedPass = System.Convert.FromBase64String(password);
            password = System.Text.Encoding.UTF8.GetString(decryptedPass);
            return password;
        }
        public static void UpdatePassword(string email, string password)
        {
            byte[] newPasswordBytes = System.Text.Encoding.UTF8.GetBytes(password);
            string newPassword = System.Convert.ToBase64String(newPasswordBytes);

            MySqlConnection con = new MySqlConnection(connection);
            using(con)
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "Update accounts set password = @password where email = @email;";
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@password", newPassword);
                cmd.ExecuteNonQuery();
            }
            con.Close();
        }
        public static int GetSchoolId(string school)
        {
            int schoolId = 0;
            MySqlConnection con = new MySqlConnection(connection);
            con.Open();
            using (con)
            {
                MySqlCommand cmd = new MySqlCommand("Select id from schools where schoolName=@name;", con);
                cmd.Parameters.AddWithValue("@name", school);
                MySqlDataReader rdr = cmd.ExecuteReader();
                while(rdr.Read())
                {
                    schoolId = rdr.GetInt32(0);
                }
                rdr.Close();
            }
            con.Close();
            return schoolId;
        }
    }
}