using System;
using System.ComponentModel.DataAnnotations;

namespace WebTest.Models
{
    public class Employee
    {
        public int Id { get; set; }

        [Required]
        public string Surname { get; set; }

        [Required]
        public string Name { get; set; }
        public string Patronymic { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Employment Date")]
        public DateTime? EmploymentDate { get; set; }

        public PositionTypes? Position { get; set; }

        [Display(Name = "Company")]
        public int? CompanyId { get; set; }

        public Company Company { get; set; }
    }
}
