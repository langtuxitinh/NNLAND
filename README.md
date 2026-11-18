# NNland — Website thuê căn hộ và quản lý cư dân

Dự án được phát triển từ **Manage-Estate-Project** bạn cung cấp, dùng **Java + Maven + Spring Boot + JSP + SQL Server 2022**, mở và chạy bằng **NetBeans**. SSMS 2022 dùng để quản trị SQL Server; không cần cài Node.js hay chạy React.

## Bắt đầu trong 3 bước

1. Cài và bật SQL Server 2022 Database Engine; SSMS một mình chưa đủ. Giải nén toàn bộ thư mục NNland.
2. Tạo database/login trong SSMS, sao chép `application-local.properties.example` thành `application-local.properties` ngay cạnh `pom.xml`, rồi điền mật khẩu SQL Server.
3. Trong NetBeans, chọn **File → Open Project**, mở thư mục chứa `pom.xml`, rồi **Run Project**. Mở **http://localhost:8081**.

Ứng dụng dùng cơ sở dữ liệu mới tên **nnland**, tự tạo các bảng `nn_*` và dữ liệu mẫu khi khởi động lần đầu. Cơ sở dữ liệu `estateadvance` cũ không được ứng dụng mới sửa hoặc xóa. Nếu tài khoản SQL Server không có quyền tạo database, chạy `database/01_create_database.sql` trong SSMS bằng tài khoản có quyền phù hợp.

Nếu tệp tải về có `target/NNland.war`, bạn cũng có thể nhấp `RUN_NNLAND.bat` trên Windows để chạy bằng Java, không cần biên dịch lại. Hướng dẫn đầy đủ: **[docs/HUONG_DAN_CAI_DAT.md](docs/HUONG_DAN_CAI_DAT.md)**.

## Tài khoản thử nghiệm

| Vai trò | Email | Mật khẩu ban đầu |
|---|---|---|
| Quản trị viên | admin@nnland.vn | NNland@2026! |
| Quản lý | manager@nnland.vn | NNland@2026! |
| Khách hàng | customer@nnland.vn | NNland@2026! |

Quản lý mẫu được phân công 4 tòa đầu; hai tòa còn lại dùng để kiểm tra việc giới hạn quyền theo tòa. Các tài khoản mẫu chỉ được thêm khi chưa tồn tại; ứng dụng không đặt lại mật khẩu bạn đã đổi.

Dữ liệu ban đầu gồm **6 tòa nhà, 30 căn hộ tại 3 thành phố**. Không tạo các giao dịch thanh toán giả để làm đẹp doanh thu. Bạn có thể chỉnh sửa, ẩn hoặc thêm tòa nhà/căn hộ trong trang quản lý.

## Các khu vực đã có

- **Trang công khai:** trang chủ NNland, hệ thống tòa nhà, tìm căn hộ theo khu vực/loại/phòng ngủ/giá/kỳ thuê, sắp xếp, phân trang, chi tiết ảnh và phí, giới thiệu, liên hệ/đặt lịch xem.
- **Tài khoản khách hàng:** hồ sơ, mật khẩu, căn hộ yêu thích, lịch hẹn, đơn thuê, lưu trú và hợp đồng, hóa đơn/phiếu thu, hỗ trợ có lịch sử trao đổi, yêu cầu hủy/trả phòng và thông báo.
- **Quản lý:** tòa nhà/căn hộ và ảnh riêng, lịch thuê từng căn, đơn đặt thuê, đối chiếu tiền thực nhận, hợp đồng/ký giấy/bàn giao, điện nước và công tơ, sửa hóa đơn chưa thu, hỗ trợ/phân công, lịch hẹn, quyết toán/hoàn tiền, báo cáo Excel/PDF.
- **Quản trị:** tài khoản và vai trò, phân công quản lý theo tòa nhà, ngân hàng và điều khoản, hàng đợi email, nhật ký thao tác.

Giao diện dùng ảnh, biểu tượng và phông chữ cục bộ. Các mẫu React và ảnh tài khoản trước đó được dùng làm tham khảo hình thức; chức năng vận hành được triển khai bằng Java/JSP và dữ liệu trong SQL Server.

## Hai cấu hình cần điền trước khi dùng thực tế

**Ngân hàng:** đăng nhập quản trị → **Cài đặt hệ thống** → điền ngân hàng, mã BIN, số tài khoản và chủ tài khoản của đơn vị vận hành. Mã VietQR được tạo từ những thông tin này. Mặc định chưa điền tài khoản nhận tiền, nên khách được hướng dẫn liên hệ NNland thay vì nhìn thấy một tài khoản ngân hàng giả.

**Email:** mặc định lưu thư vào hàng đợi, chưa gửi ra ngoài. Điền SMTP và bật `MAIL_ENABLED=true` hoặc `nnland.mail.enabled=true` theo hướng dẫn cài đặt để gửi email thật. Trạng thái **Đã gửi** chỉ xuất hiện sau khi SMTP chấp nhận thư. Hợp đồng PDF được đính kèm email xác nhận tiền thuê; thông tin trong tài khoản vẫn có ngay cả khi gửi email chưa thành công.

Thanh toán dùng chuyển khoản ngân hàng qua VietQR. Để quản lý xác nhận thủ công, đặt `nnland.sepay.manual-only=true` trong `application-local.properties` và khởi động lại. Quản lý vào **Thanh toán & đối soát → Ghi nhận tiền thực nhận** sau khi kiểm tra sao kê. Khi bật lại SePay, đặt giá trị thành `false`.

Thanh toán dùng chuyển khoản ngân hàng qua VietQR. Khi SePay báo tiền vào đúng tài khoản và nội dung chứa mã thanh toán, NNland ghi nhận số tiền thực nhận và xác nhận đơn hoặc hóa đơn khi đủ tiền. Chuyển khoản đến sau khi đơn hết hạn có thể cần quản lý đối soát.

### Bật checkout Cổng thanh toán SePay

Dùng cơ sở dữ liệu thử nghiệm khi chọn Sandbox. Trong `application-local.properties` (tệp được Git bỏ qua), điền:

```properties
nnland.base-url=https://TEN-MIEN-CONG-KHAI
nnland.sepay.gateway.mode=sandbox
nnland.sepay.gateway.merchant-id=MERCHANT_ID_CUA_BAN
nnland.sepay.gateway.checkout-key=MERCHANT_SECRET_KEY_CUA_BAN
nnland.sepay.gateway.ipn-key=SECRET_KEY_IPN_CUA_BAN
nnland.sepay.operator-email=EMAIL_QUAN_TRI_DANG_HOAT_DONG
```

Trong **Cổng thanh toán → Cấu hình → IPN** trên SePay, chọn xác thực **Secret Key**, dùng cùng khóa IPN và nhập URL `https://TEN-MIEN-CONG-KHAI/sepay/ipn`. Dùng trang NNland qua tên miền đó để phiên đăng nhập được giữ khi quay về từ SePay. Khởi động lại ứng dụng, vào một đơn đang chờ tiền và chọn **Thanh toán qua SePay**. Checkout lấy số tiền còn thiếu của đơn. NNland xác nhận sau khi xử lý IPN thành công. [Tài liệu checkout](https://developer.sepay.vn/vi/cong-thanh-toan/API/don-hang/form-thanh-toan) · [Tài liệu IPN](https://developer.sepay.vn/vi/cong-thanh-toan/IPN)

Khi dùng tiền thật, dùng `production` với bộ khóa và cấu hình IPN Production.

### Bật xác nhận chuyển khoản VietQR qua webhook biến động số dư

Nếu BIDV yêu cầu dùng VA, trong **Quản trị → Cài đặt** nhập tài khoản chính vào **Số tài khoản** và số VA chính thức vào **Tài khoản ảo (VA)**. QR dùng số VA, số tiền còn thiếu và mã thanh toán. NNland đối chiếu cả `accountNumber` và `subAccount` từ webhook.

1. Liên kết tài khoản nhận tiền thật trong **SePay Live** và nhập cùng số tài khoản trong **Quản trị → Cài đặt** của NNland.
2. Tạo webhook tiền vào cho tài khoản đó, dùng định dạng JSON và xác thực **API Key**. Trỏ webhook đến URL HTTPS công khai của NNland tại đường dẫn `/webhooks/sepay`. Cho phép gửi cả giao dịch có trường `code` rỗng để NNland đọc mã `TT-...` trong nội dung chuyển khoản.
3. Đặt biến môi trường `SEPAY_WEBHOOK_API_KEY` bằng khóa webhook và `SEPAY_OPERATOR_EMAIL` bằng email quản trị đang hoạt động dùng để ghi nhận trên phiếu thu. Khởi động lại ứng dụng.
4. Chuyển khoản thật với mã thanh toán của một đơn thử và kiểm tra trạng thái đơn cùng nhật ký gửi webhook. Giao dịch thiếu mã tham chiếu ngân hàng hoặc sai nội dung cần đối chiếu sao kê trong **Thanh toán & đối soát**.

Các phiếu thu cũ có mã `AUTO-CUSTOMER-...` cần được rà soát cùng sao kê và đơn, hợp đồng hoặc hóa đơn liên quan trước khi xử lý tiếp. [Tài liệu webhook SePay](https://developer.sepay.vn/vi/sepay-webhooks/tich-hop-webhook)


## Quy tắc chính

- Thuê **nguyên căn** theo mã căn hộ riêng trong từng tòa nhà.
- Thu trước **100% tiền thuê × số tháng**. Tiền cọc, nếu được cấu hình cho căn, hiển thị riêng. Điện nước/phí sinh hoạt lập hóa đơn riêng, không thu lại tiền nhà.
- Giữ chỗ có thời hạn; khách xác nhận thanh toán khi đơn còn hạn để tự động hoàn tất đơn. Đơn hết hạn hoặc đã hủy không được tự xác nhận. Không khóa căn chỉ vì mở trang chi tiết hoặc bấm xem biểu mẫu.
- Đủ tiền và còn lịch hợp lệ mới xác nhận hợp đồng. Nhận tiền muộn khi lịch đã bị người khác đặt chuyển sang đối soát, không chiếm lịch của khách khác.
- Ký hợp đồng giấy và bàn giao mới chuyển sang lưu trú. Hết hạn ngày thuê không tự coi căn hộ đã được trả.
- Gia hạn nối tiếp ngày kết thúc hiện tại, kiểm tra lịch và chỉ cập nhật sau khi nhận đủ tiền.
- Trả phòng cần hóa đơn cuối kỳ **YYYY-MM-FINAL** đúng ngày bàn giao, đã thanh toán, chốt chỉ số và quyết toán. Căn có thể chuyển sang sẵn sàng hoặc bảo trì.
- Mã giao dịch ngân hàng dùng chung một danh mục duy nhất cho thu/hoàn, tránh ghi nhận trùng. Báo cáo tách dòng tiền, cọc, chuyển thừa và doanh thu phân bổ.

Xem chi tiết và thao tác mẫu tại **[docs/HUONG_DAN_SU_DUNG.md](docs/HUONG_DAN_SU_DUNG.md)**; cấu trúc dữ liệu/luồng tại **[docs/KIEN_TRUC_VA_NGHIEP_VU.md](docs/KIEN_TRUC_VA_NGHIEP_VU.md)**.

## Mã nguồn và biên dịch

```text
NNland/
├── pom.xml, nb-configuration.xml, nbactions.xml
├── application-local.properties.example
├── RUN_NNLAND.bat, run-nnland.sh
├── database/                         # SQL NNland và bản gốc tham khảo
├── docs/                             # Cài đặt, vận hành, kiến trúc, kiểm thử
├── src/main/java/com/javaweb/
│   ├── SpringBootWebApplication.java # Giữ tên điểm chạy của dự án gốc
│   ├── nnland/                      # Mô-đun NNland đang hoạt động
│   │   ├── config/, model/, repository/, service/, utils/
│   │   └── controller/web/, controller/admin/
│   └── ...                          # Các lớp gốc được giữ làm tham khảo
├── src/main/resources/
│   ├── application.properties
│   ├── nnland-schema.sql
│   └── static/nnland/               # CSS, JavaScript, ảnh, font, icon
├── src/main/webapp/WEB-INF/views/nnland/
├── src/test/                         # Kiểm thử nghiệp vụ/quyền/JSP
└── target/NNland.war                 # Bản chạy sau khi build
```

Các lệnh Maven:

```bash
mvn test
mvn clean package
mvn spring-boot:run
java -jar target/NNland.war
```

JDK **25** (LTS), Maven **3.6.3+**. Maven dùng JDK 25 để build; WAR giữ bytecode/API Java 17 vì Spring Boot 2.7.18 chưa quét được class file Java 25. Để chạy theo cấu hình dự án, dùng JDK 25 trở lên. Các thay đổi so với bản gốc, môi trường và kết quả kiểm tra được ghi trong thư mục `docs/`.

Tệp **BAT_DAU_TAI_DAY.html** mở trực tiếp trên máy để xem hướng dẫn ngắn gọn. Xem **docs/DOI_UNG_NGHIEP_VU.md** để đối chiếu hành động khách hàng/quản lý với dữ liệu và **docs/KIEM_THU.md** để xem phạm vi đã kiểm tra.
