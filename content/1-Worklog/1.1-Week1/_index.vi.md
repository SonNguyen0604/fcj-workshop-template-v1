---
title: "Worklog Tuần 1"
date: 2026-06-22
weight: 1
chapter: false
pre: " <b> 1.1. </b> "
---

### Mục tiêu tuần 1:

* Kết nối, thành lập nhóm 5 thành viên và thống nhất quy chế làm việc chạy nước rút trong 5 tuần.
* Nghiên cứu tổng quan đề tài High Availability (HA) trên AWS và thiết lập hoàn chỉnh hạ tầng website báo cáo song ngữ.

### Các công việc cần triển khai trong tuần này:
<table>
  <thead>
    <tr>
      <th>Thứ</th>
      <th>Công việc</th>
      <th>Ngày bắt đầu</th>
      <th>Ngày hoàn thành</th>
      <th>Nguồn tài liệu</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>2</td>
      <td>
        <ul>
          <li>Tham gia buổi định hướng (Kick-off) chương trình thực tập Cloud Journey tại AWS Vietnam.</li>
          <li>Làm quen với các thành viên trong nhóm và thống nhất chọn Đề tài 2: Đảm bảo tính sẵn sàng cao (High Availability) trên AWS.</li>
        </ul>
      </td>
      <td>22/06/2026</td>
      <td>22/06/2026</td>
      <td>Tài liệu chương trình FCAJ</td>
    </tr>
    <tr>
      <td>3</td>
      <td>
        <ul>
          <li>Phân chia vai trò chính thức trong nhóm: Bản thân đảm nhận vai trò Quản lý tài liệu (Technical Writer) kiêm điều phối tiến độ.</li>
          <li>Nghiên cứu lý thuyết nền tảng về kiến trúc High Availability, Fault Tolerance và các thành phần cốt lõi (VPC Multi-AZ, ALB, ASG, RDS Multi-AZ).</li>
        </ul>
      </td>
      <td>23/06/2026</td>
      <td>23/06/2026</td>
      <td><a href="https://aws.amazon.com/architecture/well-architected/">AWS Well-Architected Framework (Reliability Pillar)</a></td>
    </tr>
    <tr>
      <td>4</td>
      <td>
        <ul>
          <li>Thực hiện Fork kho mã nguồn mẫu <code>fcaj-workshop-template</code> từ tài khoản mentor về tài khoản GitHub cá nhân.</li>
          <li>Kiểm tra cấu trúc các thư mục nội dung từ mục 1 đến mục 7 để chuẩn bị cho việc thay máu dữ liệu của nhóm.</li>
          <li><b>Chủ động cấu hình AWS Budgets trên tài khoản cá nhân, thiết lập hạn mức cảnh báo chi phí ở ngưỡng $5.00 để quản lý ngân sách an toàn.</b></li>
        </ul>
      </td>
      <td>24/06/2026</td>
      <td>24/06/2026</td>
      <td><a href="https://github.com/hdnkhoi-dev/fcaj-workshop-template">FCAJ Workshop Template</a> / AWS Console</td>
    </tr>
    <tr>
      <td>5</td>
      <td>
        <ul>
          <li>Chỉnh sửa và cập nhật thông tin cá nhân của Nguyễn Duy Sơn (SGU - Hệ thống thông tin) vào trang chủ Portfolio.</li>
          <li>Cấu hình đồng bộ hóa trang chủ bằng cả 2 ngôn ngữ (Tiếng Anh và Tiếng Việt) để đáp ứng yêu cầu bắt buộc của dự án.</li>
        </ul>
      </td>
      <td>25/06/2026</td>
      <td>25/06/2026</td>
      <td>Tài liệu hướng dẫn Hugo Framework</td>
    </tr>
    <tr>
      <td>6</td>
      <td>
        <ul>
          <li>Họp nhóm trực tuyến để thống nhất sơ đồ kiến trúc hệ thống HA dự kiến (Multi-AZ, Load Balancer, EC2, RDS, S3).</li>
          <li>Tổng hợp dữ liệu tuần 1 từ các thành viên, hoàn thiện file Worklog tuần 1 và lên bộ khung sơ khởi cho phần 2-Proposal.</li>
        </ul>
      </td>
      <td>26/06/2026</td>
      <td>26/06/2026</td>
      <td>AWS Study Group Documents</td>
    </tr>
  </tbody>
</table>

### KẾT QUẢ TUẦN 1: KHỞI TẠO ĐỘI NGŨ & NỀN TẢNG BÁO CÁO

1. **Gắn kết đội ngũ & Phân chia vai trò**
   - Thành lập thành công nhóm 5 thành viên với tinh thần hợp tác cao.
   - Định hình rõ ràng trách nhiệm cá nhân: Bản thân phụ trách toàn bộ hạ tầng tài liệu, website portfolio và dịch thuật song ngữ, giải phóng áp lực viết báo cáo cho các thành viên chuyên trách kỹ thuật.

2. **Thiết lập nền tảng tài liệu & Giám sát hệ thống**
   - Làm chủ công cụ Git/GitHub ở mức độ cơ bản thông qua thao tác Fork và cấu hình file Markdown.
   - Hoàn thành việc cá nhân hóa trang chủ báo cáo thực tập song ngữ mà không làm lỗi cấu trúc định tuyến của template gốc.
   - Kích hoạt thành công tính năng giám sát chi phí chủ động (Cost Monitoring) trên AWS để bảo vệ tài khoản.

3. **Thống nhất kiến trúc & Kế hoạch hành động**
   - Toàn đội đạt được sự đồng thuận về mặt kỹ thuật đối với sơ đồ kiến trúc High Availability tổng quan.
   - Thiết lập thành công timeline chi tiết 8 tuần (kết thúc vào ngày 15/08/2026) theo đúng lịch trình của nhà trường để kịp tiến độ nghiệm thu dự án.

### MINH CHỨNG THỰC HIỆN (EVIDENCE)

<img width="1903" height="540" alt="image" src="https://github.com/user-attachments/assets/51a003ec-aab5-4323-bec7-0552fdd30d7b" />
