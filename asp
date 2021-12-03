private ApplicationDbContext context;

        public EFCRUDCourseRepository(ApplicationDbContext context)
        {
            this.context = context;
        }

        public Course Add(Course course)
        {
            EntityEntry<Course> entityEntry = context.Courses.Add(course);
            context.SaveChanges();
            return entityEntry.Entity;
        }

        public void Delete(int id)
        {
            context.Courses.Remove(context.Courses.Find(id));
            context.SaveChanges();
        }

        public IList<Course> FindAll()
        {

            return context.Courses.ToList();

        }

        public Course FindById(int id)
        { 

            return context.Courses.Find(id);
        }

        public IList<Course> FindPage(int page, int size)
        {
            return (from course in context.Courses orderby (course.First_Name) select course)
                .Skip(page * size)
                .Take(size)
                .ToList();
        }

        public Course Update(Course course)
        {
            EntityEntry<Course> entityEntry = context.Courses.Update(course);
            context.SaveChanges();
            return entityEntry.Entity;
        }



private ICRUDCourseRepository courses;

        public CourseController(ICRUDCourseRepository courses)
        {
            this.courses = courses;


        [HttpPost]
        public IActionResult Add(Course course)
        {
            if (ModelState.IsValid)
            {
                course = courses.Add(course);
                //return View("ConfirmCourse", course);
                return View("List", course);
            }
            else
            {
                return View();
            }
        }

        public IActionResult Delete(int id)
        {
            courses.Delete(id);
            return View("List", courses.FindAll());
        }





