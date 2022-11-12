# Swift

##  TableViewの実装
 - .storyboard
 - ViewControllerにTableViewを追加
 - TableViewCellを追加
 - ViewController
 - UITableViewDataSource Protocolを継承
 - func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {}
 - func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {}
 - let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
 - tableView.dataSource = self
