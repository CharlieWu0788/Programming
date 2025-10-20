public class Oct20
{
    public static class Person
    {
        private String name;
        private String gender;
        private int age;

        public void setName(String name)
        {
            this.name = name;
        }
        public String getName()
        {
            return this.name;
        }
        
        public void setGender(String gender)
        {
            this.gender = gender;
        }
        public String getGender()
        {
            return this.gender;
        }

        public void setAge(int age)
        {
            this.age = age;
        }
        public int getAge()
        {
            return this.age;
        }

        public Person(String name, String gender, int age)
        {
            this.name = name;
            this.gender = gender;
            this.age = age;
        }

        @Override
        public String toString()
        {
            return "Name: " + this.getName() + "\n" + 
                   "Gender: " + this.getGender() + "\n" +
                   "Age: " + this.getAge() + "\n";
        }

        public static class Student extends Person
        {
            private boolean full_status;
            private String resident_hall;

            public void setFullStatus(boolean full)
            {
                this.full_status = full;
            }
            public boolean getFullStatus()
            {
                return this.full_status;
            }

            public void setResidentHall(String dorm)
            {
                this.resident_hall = dorm;
            }
            public String getResidentHall()
            {
                return this.resident_hall;
            }
            public Student(String name, String gender, int age, boolean full_status, String resident_hall)
            {
                super(name, gender, age);
                this.full_status = full_status;
                this.resident_hall = resident_hall;
            }
            @Override
            public String toString()
            {
                return super.toString() +
                       "Full Time Status: " + this.full_status + "\n" +
                       "Resident Hall: " + this.resident_hall + "\n";
            }
        }
        
        public static class Staff extends Person
        {
            private String department;
            private String position;

            public void setPosition(String position)
            {
                this.position = position;
            }
            public String getPosition()
            {
                return this.position;
            }

            public void setDepartment(String department)
            {
                this.department = department;
            }
            public String getDepartment()
            {
                return this.department;
            }

            public Staff(String name, String gender, int age, String department, String position)
            {
                super(name, gender, age);
                this.department = department;
                this.position = position;
            }

            @Override
            public String toString()
            {
                return super.toString() +
                       "Department: " + this.department + "\n" +
                       "Position: " + this.position + "\n";
            }
        
            public static class Professor extends Staff
            {
                private String expertise;
                private int education_experience;
                private String office;

                public void setExpertise(String expertise)
                {
                    this.expertise = expertise;
                }
                public String getExpertise()
                {
                    return this.expertise;
                }

                public void setEducationExperience(int years)
                {
                    this.education_experience = years;
                }
                public int getEducationExperience()
                {
                    return this.education_experience;
                }

                public void setOffice(String office)
                {
                    this.office = office;
                }
                public String getOffice()
                {
                    return this.office;
                }

                public Professor(String name, String gender, int age, String department, String position, String expertise, int education_experience, String office)
                {
                    super(name, gender, age, department, position);
                    this.expertise = expertise;
                    this.education_experience = education_experience;
                    this.office = office;
                }

                @Override
                public String toString()
                {
                    return super.toString() +
                           "Expertise: " + this.expertise + "\n" +
                           "Education Experience: " + this.education_experience + " years\n" +
                           "Office: " + this.office + "\n";
                }
            }
        }
    }
    public static void main(String[] args)
    {
        Person me = new Person("Charlie", "Male", 18);
        System.out.println(me);

        Person.Student now_me = new Person.Student("Charlie", "Male", 18, true, "Berkus House");
        System.out.println(now_me);

        Person.Staff.Professor hector = new Person.Staff.Professor("Hector", "Male", 30, "Computer Science", "Professor", "Artificial Intelligence", 5, "Room 101");
        System.out.println(hector);
    }
}