using System.Collections.Generic;
using WebTest.Models;

namespace WebTest.Interfaces
{
    public interface IEmployeeService
    {
        public IList<Employee> GetList();
        public void Insert(Employee employee);
        public Employee GetById(int id);
        public void Edit(Employee employee);
        public void Delete(int id);
    }
}
