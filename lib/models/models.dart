// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────

class AppUser {
  final String fullName;
  final String email;
  final String department;
  final String classYear;
  final String studentId;
  final String initials;
  final double profileStrength;
  final String gender;

  const AppUser({
    required this.fullName,
    required this.email,
    required this.department,
    required this.classYear,
    required this.studentId,
    required this.initials,
    required this.profileStrength,
    required this.gender,
  });
}

class StudentStatus {
  final String gpa;
  final String nextClass;
  final String classTime;
  final String classRoom;

  const StudentStatus({
    required this.gpa,
    required this.nextClass,
    required this.classTime,
    required this.classRoom,
  });
}

class NewsArticle {
  final String category;
  final String title;
  final String date;
  final String imageUrl;
  final bool isFeatured;

  const NewsArticle({
    required this.category,
    required this.title,
    required this.date,
    required this.imageUrl,
    this.isFeatured = false,
  });
}

class Product {
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final String condition;
  final String seller;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.condition,
    required this.seller,
  });
}

// ─────────────────────────────────────────────
//  MOCK DATA
// ─────────────────────────────────────────────

const mockUser = AppUser(
  fullName: 'Muhammad Qaseem',
  email: 'qaseem@ubit.edu',
  department: 'Computer Science & Engineering',
  classYear: 'Class of 2025',
  studentId: 'B23110106040',
  initials: 'MQ',
  profileStrength: 0.85,
  gender: 'Male',
);

const mockStatus = StudentStatus(
  gpa: '3.82',
  nextClass: 'CS-401',
  classTime: '10:00 – 11:30',
  classRoom: 'Room 4-B',
);

const List<NewsArticle> mockNews = [
  NewsArticle(
    category: 'FEATURED',
    title: 'New Research Grant Awarded to Engineering Faculty',
    date: 'June 12, 2025',
    imageUrl:
        'https://images.unsplash.com/photo-1696264940490-ff9e371c324c?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    isFeatured: true,
  ),
  NewsArticle(
    category: 'ACADEMIC',
    title: 'Registration for Fall Semester Opens Next Tuesday',
    date: 'June 10, 2025',
    imageUrl:
        'https://images.unsplash.com/photo-1484807352052-23338990c6c6?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  NewsArticle(
    category: 'EVENT',
    title: 'Annual Career Fest For Year 2027',
    date: 'Announcing Soon',
    imageUrl:
        'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=400',
  ),
  NewsArticle(
    category: 'WORKSHOP',
    title: 'ICIST Conference 2026',
    date: 'April 16, 2026',
    imageUrl:
        'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=400',
  ),
];

const List<String> filterCategories = [
  'All',
  'Textbooks',
  'Laptops',
  'Electronics',
  'Stationery',
  'Furniture',
];

const List<Product> mockProducts = [
  Product(
    name: 'Fundamentals of Algorithms',
    category: 'Textbooks',
    price: 35.00,
    imageUrl:
        'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?q=80&w=873&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    condition: 'Like New',
    seller: 'BookStore',
  ),
  Product(
    name: 'MacBook Pro 14" M1',
    category: 'Laptops',
    price: 502.00,
    imageUrl:
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
    condition: 'Good',
    seller: 'Tech & Gadgets',
  ),
  Product(
    name: 'Modern Sociology Vol. 1',
    category: 'Textbooks',
    price: 18.00,
    imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400',
    condition: 'Acceptable',
    seller: 'Book Store',
  ),
  Product(
    name: 'Mechanical Keyboard',
    category: 'Electronics',
    price: 85.00,
    imageUrl:
        'https://images.unsplash.com/photo-1511467687858-23d96c32e4ae?w=400',
    condition: 'Like New',
    seller: 'Tech & Gadgets',
  ),
  Product(
    name: 'Smartwatch Series 8',
    category: 'Electronics',
    price: 120.00,
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
    condition: 'Good',
    seller: 'Tech & Gadgets',
  ),
  Product(
    name: 'Graphics Calculator',
    category: 'Stationery',
    price: 45.00,
    imageUrl:
        'https://images.unsplash.com/photo-1648201637025-1c77b9be3013?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    condition: 'Like New',
    seller: 'Campus Store',
  ),
  Product(
    name: 'Data Structures & Algorithms',
    category: 'Textbooks',
    price: 28.00,
    imageUrl: 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400',
    condition: 'Good',
    seller: 'BookStore',
  ),
  Product(
    name: 'Wireless Mouse',
    category: 'Electronics',
    price: 22.00,
    imageUrl:
        'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400',
    condition: 'Like New',
    seller: 'Tech & Gadgets',
  ),
];

const List<String> departments = [
  'Computer Science & Engineering',
  'Electrical Engineering',
  'Software Engineering',
  'Mechanical Engineering',
  'Business Administration',
  'Mathematics & Statistics',
];

const List<String> genderOptions = [
  'Male',
  'Female',
  'Non-binary',
  'Prefer not to say',
];
