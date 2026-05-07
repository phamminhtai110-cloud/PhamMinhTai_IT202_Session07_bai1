-- =========================================
-- MODULE: So sánh Học phí
-- FIX ERROR: Subquery returns more than 1 row
-- =========================================

/*
PHÂN TÍCH LỖI
------------------------------------------------
Dev cũ viết dạng:

SELECT *
FROM Courses
WHERE price = (
    SELECT price
    FROM Courses
    WHERE instructor_id = 5
);

Toán tử "=" chỉ chấp nhận 1 giá trị duy nhất.

Ban đầu:
- instructor_id = 5 chỉ có 1 khóa học
=> Subquery trả về 1 dòng
=> Code chạy bình thường.

Sau này:
- Giảng viên mở thêm nhiều khóa học
=> Subquery trả về nhiều dòng giá khác nhau
=> SQL không thể xử lý:

price = (499, 799, 999)

=> MySQL báo lỗi:
"Subquery returns more than 1 row"
*/


-- =========================================
-- CÂU LỆNH SQL ĐÚNG (FIX)
-- =========================================

SELECT *
FROM Courses
WHERE price IN (
    SELECT price
    FROM Courses
    WHERE instructor_id = 5
);


-- =========================================
-- GIẢI THÍCH
-- =========================================
/*
IN dùng để so sánh với nhiều giá trị.

Ví dụ:
Subquery trả về:

499
799
999

SQL sẽ hiểu:

WHERE price IN (499, 799, 999)

=> Không còn crash hệ thống.
=> Dù giảng viên có 1 hay 100 khóa học vẫn chạy đúng.
*/