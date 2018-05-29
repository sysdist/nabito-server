user = CreateUserService.new.admin
puts 'CREATED ADMIN USER: ' << user.email
CreateUserService.new.users
puts "created sample users"

ElSocket.create!([
  {user_id: 1, code: "S1", url: "", address: "", gps_lat: nil, gps_lng: nil,
   voltage: 230, i_limit: 16, price_per_kWh: 0.3, status: 0, current_user: nil, 
   frequency: 5, mqtt_id: "random00MQTTid"}
])

SocketUsage.create!([
  {user_id: 1, el_socket_id: 1, start_time: "2017-06-02 12:04:03", end_time: "2017-06-02 12:42:20", kWhs: 0.0263776379361082, amount: 0.00791329138083245, date: "2017-06-02",
    start_tag: "25FB4DBE", end_tag: "25FB4DBE"}
 ])
 
 Tag.create!([
   {user_id: 7, tag_type: "RFID", uid: "25FB4DBE" }
 ])

SocketLoad.create!([
  {el_socket_id: 1, i_total: 0.0, v_avg: 230.0, p_total: 0.139, time: "2017-06-02 12:05:23"},
  {el_socket_id: 1, i_total: 0.34, v_avg: 230.0, p_total: 16.672, time: "2017-06-02 12:06:23"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 74.185, time: "2017-06-02 12:07:23"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 72.582, time: "2017-06-02 12:08:24"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 71.523, time: "2017-06-02 12:09:24"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 72.22, time: "2017-06-02 12:10:24"},
  {el_socket_id: 1, i_total: 0.31, v_avg: 230.0, p_total: 71.76, time: "2017-06-02 12:11:24"},
  {el_socket_id: 1, i_total: 0.31, v_avg: 230.0, p_total: 71.858, time: "2017-06-02 12:12:25"},
  {el_socket_id: 1, i_total: 0.31, v_avg: 230.0, p_total: 71.453, time: "2017-06-02 12:13:25"},
  {el_socket_id: 1, i_total: 0.31, v_avg: 230.0, p_total: 72.304, time: "2017-06-02 12:14:25"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 73.126, time: "2017-06-02 12:15:25"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 72.931, time: "2017-06-02 12:16:26"},
  {el_socket_id: 1, i_total: 0.31, v_avg: 230.0, p_total: 72.29, time: "2017-06-02 12:17:26"},
  {el_socket_id: 1, i_total: 0.31, v_avg: 230.0, p_total: 72.847, time: "2017-06-02 12:18:26"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 72.736, time: "2017-06-02 12:19:26"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 73.321, time: "2017-06-02 12:20:27"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 73.196, time: "2017-06-02 12:21:27"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 71.76, time: "2017-06-02 12:22:27"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 72.178, time: "2017-06-02 12:23:27"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 73.795, time: "2017-06-02 12:24:28"},
  {el_socket_id: 1, i_total: 0.34, v_avg: 230.0, p_total: 46.822, time: "2017-06-02 12:25:28"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 75.328, time: "2017-06-02 12:26:28"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 73.837, time: "2017-06-02 12:27:28"},
  {el_socket_id: 1, i_total: 0.33, v_avg: 230.0, p_total: 74.402, time: "2017-06-02 12:28:29"},
  {el_socket_id: 1, i_total: 0.33, v_avg: 230.0, p_total: 75.426, time: "2017-06-02 12:29:29"},
  {el_socket_id: 1, i_total: 0.0, v_avg: 230.0, p_total: 42.477, time: "2017-06-02 12:30:29"},
  {el_socket_id: 1, i_total: 0.3, v_avg: 230.0, p_total: 59.059, time: "2017-06-02 12:31:29"},
  {el_socket_id: 1, i_total: 0.0, v_avg: 230.0, p_total: 47.053, time: "2017-06-02 12:32:30"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 62.8, time: "2017-06-02 12:33:30"},
  {el_socket_id: 1, i_total: 0.31, v_avg: 230.0, p_total: 73.122, time: "2017-06-02 12:34:31"},
  {el_socket_id: 1, i_total: 0.31, v_avg: 230.0, p_total: 73.447, time: "2017-06-02 12:35:31"},
  {el_socket_id: 1, i_total: 0.33, v_avg: 230.0, p_total: 74.213, time: "2017-06-02 12:36:31"},
  {el_socket_id: 1, i_total: 0.34, v_avg: 230.0, p_total: 76.081, time: "2017-06-02 12:37:31"},
  {el_socket_id: 1, i_total: 0.33, v_avg: 230.0, p_total: 76.039, time: "2017-06-02 12:38:31"},
  {el_socket_id: 1, i_total: 0.32, v_avg: 230.0, p_total: 75.802, time: "2017-06-02 12:39:32"},
  {el_socket_id: 1, i_total: 0.33, v_avg: 230.0, p_total: 75.761, time: "2017-06-02 12:40:32"},
  {el_socket_id: 1, i_total: 0.33, v_avg: 230.0, p_total: 75.496, time: "2017-06-02 12:41:32"},
])
