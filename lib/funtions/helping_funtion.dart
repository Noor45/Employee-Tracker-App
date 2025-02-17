import '../controller/employee_controller.dart';
import '../controller/manager_controller.dart';

getEmployeeData() async{
  await EmployeeController.getEmployeeWorkingHours();
  await EmployeeController.getEmployeeTodayAttendance();
  // await ExpenseController.getTransactionLists();
 }

getManagerData() async{
  await ManagerController.getManagerWorkingHours();
  await ManagerController.getManagerTodayAttendance();
  await ManagerController.geEmployees();
  // await ExpenseController.getTransactionLists();
}