---
title: "Worklog Tuần 2"
date: 2026-06-24
weight: 2
chapter: false
pre: " <b> 1.2. </b> "
---

### Mục tiêu tuần 2:

* Làm chủ kiến thức nền tảng về AWS Networking, thiết lập hệ thống máy chủ và giải pháp kết nối an toàn.
* Xây dựng và chuẩn hóa hạ tầng tài liệu hướng dẫn kỹ thuật cho nhóm, chuẩn bị bộ khung giám sát hệ thống CloudWatch.

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
          <li>
            Tìm hiểu Amazon VPC & kiến thức nền tảng về Networking:
            <ul>
              <li>Tạo VPC, Subnet, Internet Gateway, Route Table và Security Group.</li>
              <li>Bật VPC Flow Logs để thu thập dữ liệu lưu lượng mạng IP.</li>
              <li><i>Bản thân: Tổng hợp tài liệu, ghi chép lại các thông số mạng cấu hình chuẩn của nhóm.</i></li>
            </ul>
          </li>
        </ul>
      </td>
      <td>29/06/2026</td>
      <td>29/06/2026</td>
      <td><a href="https://000003.awsstudygroup.com/3-prerequisite/">AWS Study Group Lab 3</a></td>
    </tr>
    <tr>
      <td>3</td>
      <td>
        <ul>
          <li>
            Triển khai Amazon EC2 Instances & Hạ tầng giám sát cơ sở:
            <ul>
              <li>Khởi tạo EC2 Server, cấu hình NAT Gateway và EC2 Instance Connect Endpoint.</li>
              <li>Kiểm tra kết nối bảo mật tới server từ xa bằng VS Code.</li>
              <li><b>Cá nhân đảm nhiệm: Nghiên cứu cấu hình CloudWatch Monitoring & Alerting cho các instance mới tạo.</b></li>
            </ul>
          </li>
        </ul>
      </td>
      <td>30/06/2026</td>
      <td>30/06/2026</td>
      <td><a href="https://000003.awsstudygroup.com/4-createec2server/">AWS Study Group Lab 4</a></td>
    </tr>
    <tr>
      <td>4</td>
      <td>
        <ul>
          <li>
            Tìm hiểu thiết lập Site-to-Site VPN Connection trên AWS:
            <ul>
              <li>Mô phỏng môi trường hybrid bằng cách tạo môi trường VPN và cấu hình VPN Connection.</li>
              <li>Cấu hình đường hầm VPN kết hợp công cụ Strongswan với Transit Gateway.</li>
            </ul>
          </li>
        </ul>
      </td>
      <td>01/07/2026</td>
      <td>01/07/2026</td>
      <td><a href="https://000003.awsstudygroup.com/5-vpnsitetosite/">AWS Study Group Lab 5</a></td>
    </tr>
    <tr>
      <td>5</td>
      <td>
        <ul>
          <li>
            Tìm hiểu triển khai Microsoft Active Directory trên AWS:
            <ul>
              <li>Chuẩn bị các tài nguyên tự động hóa (Key pair, CloudFormation template và Security Group).</li>
              <li>Triển khai Microsoft AD, thiết lập Private DNS và kết nối an toàn qua RDGW.</li>
              <li><i>Bản thân: Biên tập tài liệu hướng dẫn xử lý lỗi kết nối tên miền (Domain) cho nhóm.</i></li>
            </ul>
          </li>
        </ul>
      </td>
      <td>02/07/2026</td>
      <td>02/07/2026</td>
      <td><a href="https://000010.awsstudygroup.com/">AWS Directory Service Docs</a></td>
    </tr>
    <tr>
      <td>6</td>
      <td>
        <ul>
          <li>
            Tìm hiểu triển khai và bảo mật liên kết VPC Peering Connections:
            <ul>
              <li>Cập nhật Network ACL, cấu hình VPC Peering và phân giải tên miền chéo (Cross-Peer DNS).</li>
              <li><b>Cá nhân đảm nhiệm: Tổng hợp toàn bộ dữ liệu thực hành, hoàn thiện Worklog tuần 2 và phác thảo outline bài Blog số 1 cho team.</b></li>
            </ul>
          </li>
        </ul>
      </td>
      <td>03/07/2026</td>
      <td>03/07/2026</td>
      <td><a href="https://000002.awsstudygroup.com/">AWS VPC Peering Lab</a></td>
    </tr>
  </tbody>
</table>

### THÀNH TỰU TUẦN 2: MẠNG NÂNG CAO & TRIỂN KHAI HẠ TẦNG

1. **Mạng AWS & kiến trúc VPC tổng thể**
   - **Nền tảng VPC:** Phối hợp cùng nhóm thiết kế thành công mạng Virtual Private Cloud (VPC) tùy chỉnh phục vụ hạ tầng sẵn sàng cao, chia tách public/private subnets rõ ràng.
   - **Kiểm soát lưu lượng:** Cấu hình chuẩn hóa hệ thống Route Tables, Security Groups và bật VPC Flow Logs giúp thu thập dữ liệu traffic chính xác, phục vụ công tác giám sát sự cố mạng.

2. **Hạ tầng EC2 Compute & Giải pháp quan sát (CloudWatch)**
   - **Triển khai instance:** Khởi tạo thành công các máy chủ Amazon EC2 thử nghiệm, thiết lập định tuyến an toàn qua NAT Gateways và kết nối bảo mật thông qua VS Code.
   - **Nền tảng giám sát cá nhân:** Bản thân tự tay thiết lập cấu hình CloudWatch baseline metrics cho các máy chủ EC2, chuẩn bị sẵn sàng cho bộ khung cảnh báo lỗi tự động ở các giai đoạn sau.

3. **Kết nối hỗn hợp Hybrid & Quản lý thư mục định danh**
   - **Đường hầm VPN bảo mật:** Nắm vững cách thức xây dựng kênh kết nối an toàn giữa mạng on-prem và AWS thông qua công cụ Strongswan phối hợp Transit Gateway.
   - **Quản trị Microsoft AD:** Tìm hiểu quy trình triển khai Microsoft Active Directory tự động hóa qua CloudFormation, quản trị an toàn từ xa qua Remote Desktop Gateway (RDGW).

4. **Tối ưu hóa quản lý tài liệu nhóm (Technical Writing)**
   - Hoàn thành xuất sắc vai trò Quản lý tài liệu: Biên tập, hệ thống hóa toàn bộ các bước cấu hình VPC Peering và xử lý lỗi kết nối DNS chéo giữa các phân vùng mạng.
   - Lên khung nội dung chi tiết bài Blog kỹ thuật số 1 để chuẩn bị đăng tải lên cộng đồng Facebook.
