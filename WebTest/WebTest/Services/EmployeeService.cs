using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using WebTest.Models;
using Microsoft.Extensions.Configuration;
using WebTest.Interfaces;

namespace WebTest.Services
{
    public class EmployeeService : IEmployeeService
    {
        private string connectionString;
        private SqlDataAdapter dataAdapter;

        public EmployeeService(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString(Constants.ConnectionName);
        }

        public IList<Employee> GetList()
        {
            IList<Employee> list = new List<Employee>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("EmployeeList", connection);
                command.CommandType = CommandType.StoredProcedure;
                dataAdapter = new SqlDataAdapter(command);
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet);
                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < dataSet.Tables[0].Rows.Count; i++)
                    {
                        Employee employee = new Employee();
                        FillInstance(employee, dataSet.Tables[0].Rows[i]);
                        list.Add(employee);
                    }
                }
            }
            return list;
        }

        public void Insert(Employee employee)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("InsertEmployee", connection);
                command.CommandType = CommandType.StoredProcedure;
                FillParameters(command.Parameters, employee);
                command.ExecuteNonQuery();
            }
        }

        public Employee GetById(int id)
        {
            Employee employee = new Employee();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("GetEmployee", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", id);
                dataAdapter = new SqlDataAdapter(command);
                DataSet dataSet = new DataSet();
                dataAdapter.Fill(dataSet);
                if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                {
                    FillInstance(employee, dataSet.Tables[0].Rows[0]);
                }
            }
            return employee;
        }

        public void Edit(Employee employee)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("EditEmployee", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", employee.Id);
                FillParameters(command.Parameters, employee);
                command.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("DeleteEmployee", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", id);
                command.ExecuteNonQuery();
            }
        }

        private void FillParameters(SqlParameterCollection parameters, Employee employee)
        {
            parameters.AddWithValue("@Surname", employee.Surname);
            parameters.AddWithValue("@Name", employee.Name);
            parameters.AddWithValue("@Patronymic", employee.Patronymic);
            parameters.AddWithValue("@EmploymentDate", employee.EmploymentDate);
            parameters.AddWithValue("@Position", (employee.Position == PositionTypes.BusinessAnalyst) ? "Business Analyst" : employee.Position.ToString());
            parameters.AddWithValue("@CompanyId", employee.CompanyId);
        }

        private void FillInstance(Employee employee, DataRow row)
        {
            employee.Id = Convert.ToInt32(row["Id"]);
            employee.Surname = Convert.ToString(row["Surname"]);
            employee.Name = Convert.ToString(row["Name"]);
            employee.Patronymic = Convert.ToString(row["Patronymic"]);
            employee.EmploymentDate = (row["EmploymentDate"] is DBNull) ? null : Convert.ToDateTime(row["EmploymentDate"]);
            employee.Position = (PositionTypes?)Enum.Parse(typeof(PositionTypes), Convert.ToString(row["Position"]).Replace(" ", String.Empty));
            employee.CompanyId = (row["CompanyId"] is DBNull) ? null : Convert.ToInt32(row["CompanyId"]);
            if (employee.CompanyId != null)
            {
                Company company = new Company();
                employee.Company = company;
                company.Id = (int)employee.CompanyId;
                company.Name = Convert.ToString(row["CompanyName"]);
                company.Type = Convert.ToString(row["CompanyType"]);
            }
        }
    }
}
