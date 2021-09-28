# day1

생성일: 2021년 9월 27일 오전 10:12

## 1. 화면 전환

- 화면 전환하는 방법은 두가지 방법이 있다.
    - navigationController
    - TabBarController

### 1. UINavigationController

- 뒤로가기 → 네비게이션 바

![스크린샷 2021-09-27 오전 10.16.10.png](https://github.com/minimanin/ios_dev_course_2021_p2/blob/master/%EA%B0%95%EC%9D%98%20%EC%A0%95%EB%A6%AC%20%EB%82%B4%EC%9A%A9/md_images/day1_images/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-27_%EC%98%A4%EC%A0%84_10.16.10.png)

- 요소를 클릭하면 그 요소 화면으로 이동한다. (depth가 깊어진다. )

![스크린샷 2021-09-27 오전 10.16.57.png](day1%20ff8a8f475555405d824b845acec22a23/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-09-27_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_10.16.57.png)

- RootViewController → 첫번째 화면
- 사용자는 전체를 본다.
    - 화면이 쌓였다가 POP 된다. → Stack 구조
    - Stack 구조(LIFO) : Last In First Out
        - push 한 뒤 pop 한다.
        

**진입점 변경 방법**

- storyboard의 Attributes에서 View Controller 의 Is Initial View Controller 체크박스를 체크하면 해당 뷰가 진입점이 된다.

**삭제하기**

- Move to Trash
    - 아예 삭제
- Remove Reference
    - 파일은 삭제되지 않는다. 프로젝트에서만 삭제

- Navigation 연결 방법
    - 오른쪽 마우스로 연결하면 밑의 그림처럼 뜸
        
        ![스크린샷 2021-09-27 오전 10.30.40.png](day1%20ff8a8f475555405d824b845acec22a23/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-09-27_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_10.30.40.png)
        
        - deprecated : 쓰지 않는다. (옛날 버전으로 쓸 수 있다.)
        - Relationship Segue : 관계를 맺어준다.
            - root view controller : 해당 뷰를 루트로 설정한다.
    
- **화면 전환하기**
    - 추가한 버튼에서 오른쪽 마우스를 클릭한 후 전환할 뷰에 연결한다.
        
        ![스크린샷 2021-09-27 오전 10.37.49.png](day1%20ff8a8f475555405d824b845acec22a23/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-09-27_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_10.37.49.png)
        
        - Show Detail, Present As Popover : 아이패드 전용
    - Show 클릭 후 뒤로가기 버튼이 생김
        
        ![스크린샷 2021-09-27 오전 10.38.42.png](day1%20ff8a8f475555405d824b845acec22a23/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-09-27_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_10.38.42.png)
        
    - Present Modally 연결 후 아래에서 모달이 올라옴
        
        ![스크린샷 2021-09-27 오전 10.42.58.png](day1%20ff8a8f475555405d824b845acec22a23/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-09-27_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_10.42.58.png)
        
    
    대부분의 경우 show를 쓰고 선택지가 있을 경우 Present Modally을 사용
    
     두 개의 경우를 같이 쓰진 않고 각 따로 뷰를 만들어서 사용한다. 
    

Warning이 뜨는 이유

- 아이폰 화면의 크기가 여러 개여서 자동으로 맞춰주려면 Auto Layout으로 해야한다고 알려주는 것!

![스크린샷 2021-09-27 오전 10.50.57.png](day1%20ff8a8f475555405d824b845acec22a23/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-09-27_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_10.50.57.png)

- 이전 뷰로 또 Show를 이용한 화면 전환을 한다면 그대로 스택이 쌓인다.

- swift 파일과 뷰를 연결시키는 법
    - 주의할 점
        - 뷰를 잘 선택해야한다. 위 바의 ViewController 를 선택하기
    - Identity 에서 Class를 지정해준다.

- 이전 뷰로 이동하기
    - 버튼을 코드로 끌어 action을 추가한다. (actBack)
    - `self` : viewControllerC
    - `navigationController` : root navigation view (Optional)
    
    Optional
    모든 뷰가 navigationController가 아니기 때문에
    
    - `popViewController` : view controller를 pop한다.(하나를 뺀다)
        - animated : 애니메이션 추가 여부
    
    ```swift
    @IBAction func actBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    ```
    
- 루트 뷰로 이동하기
    - 버튼을 코드로 끌어 action을 추가한다. (actToRoot)
    - `popToRootViewController` : 루트 뷰로 화면 전환
    
    ```swift
    @IBAction func actToRoot(_ sender: UIButton) {
    	  self.navigationController?.popToRootViewController(animated: true)
    }
    ```
    
- 특정 뷰로 이동하기
    - 버튼을 코드로 끌어 action을 추가한다. (actPopTo)
    - `popToViewController` : 특정 뷰로 화면 전환
    - array로 전달된다. (아래에서부터 0, 1, 2, 3 식으로 index가 정해짐)
        - 내가 원하는 뷰인지 체크 후 이동
        - 체크하려면  언래핑을 해야한다.
            - `if let` : 언래핑 하려는 요소가 블럭 내에서만 가능
                
                ```swift
                // if let을 이용해서 언래핑
                if let viewControllers = self.navigationController?.viewControllers {
                   for viewController in viewControllers {
                       if viewController is ViewControllerA {
                          self.navigationController?.popToViewController(viewController, animated: true)
                       }
                   }
                }
                ```
                
            - `guard let` : 리턴을 해야한다. nil일 경우 리턴시킨다.
                
                ```swift
                // guard let을 이용해서 언래핑
                guard let viewControllers = self.navigationController?.viewControllers else { return }
                        
                for viewController in viewControllers {
                    // viewControllerA 일 때만 코드 실행
                    if let vc = viewController as? ViewControllerA {
                       self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
                ```
                
        - 언래핑 후 viewController의 타입을 체크
        - 체크 후 `popToViewController`로 해당 뷰로 전환
        
- 코드로 화면 이동시키기
    - **storyboard ID** 지정하기
        
        주의! ID를 꼭 맞춰줘야한다!
        
    - `self.storyboard` : ViewControllerC가 속해있는 storyboard
    - `instantiateViewController(identifier: "yellow")` : 설정한 storyboard id가 있는 뷰
    - 해당 뷰가 없을 수도 있기 때문에 언래핑을 해야한다.
    - `pushViewController` : 뷰를 쌓는다.
    
    ```swift
    @IBAction func toYellow(_ sender: UIButton) {
      if let yellowVC = self.storyboard?.instantiateViewController(identifier: "yellow") {
         self.navigationController?.pushViewController(yellowVC, animated: true)
      }
    }
    ```
    

### 앱 만들기

- 예제) 테이블뷰에서 화면 전환하기
- 기본 ViewController 삭제 후 Navigation Controller 추가
- 진입점을 Navigation Controller 로 변경
    - View Controller → Is Initial View Controller 체크
- 클래스 생성 →  UITableViewController 상속
- TableViewController의 Class indentity 설정
- View Controller 와 Cell을 연결
    
    ![스크린샷 2021-09-27 오후 2.10.27.png](day1%20ff8a8f475555405d824b845acec22a23/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_2.10.27.png)
    
- Selection Segue의 Show 선택
- 전환될 ViewController의 클래스 생성 → UIViewController 상속
- ViewController의 Class indentity 설정
- tableView Section 갯수 설정 → 1
- tableViewCell 갯수 설정 → `seolInfo.count`
- 구현
    
    ```swift
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
       let dic = seolInfo[indexPath.row]
           
       if let imageView = cell.viewWithTag(1) as? UIImageView {
           if let imageName = dic["img"] {
              imageView.image = UIImage(named: imageName)
           }
       }
    
       if let lblTitle = cell.viewWithTag(2) as? UILabel {
           lblTitle.text = dic["title"]
       }
    
       if let lblCute = cell.viewWithTag(3) as? UILabel {
           lblCute.text = dic["cute"]
       }
    
       return cell
    }
    ```
    
- Detail view 구현
- 값 넘기기
    - 아웃렛 생성
    - `var info:[String:String]?` : 외부에서 값이 넘어오기 때문에 값이 세팅되지 않으면 Optional로 설정
    
    ```swift
    guard let info = self.info else {return}
            
    if let imageName = info["img"] {
       imageView.image = UIImage(named: imageName)
    }
    
    lblTitle.text = info["title"]
    ```
    
    - push 하기 전에 값을 넘겨야한다. → `prepare` function 이용
    - 포괄적이라 선택된 값을 알 수 없다. → 테이블뷰에서 가져와야함
    - `tableView.indexPathForSelectedRow` : 현재 선택되어있는 row를 반환해준다.
    
    ```swift
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let indexPath = tableView.indexPathForSelectedRow {
    		  if let destVC = segue.destination as? DetailViewController {
              destVC.info = seolInfo[indexPath.row]
          }
       }
    }
    ```
    

### 2. UITabBarController

![스크린샷 2021-09-27 오후 4.16.50.png](day1%20ff8a8f475555405d824b845acec22a23/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-09-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_4.16.50.png)

- 나란히 있다.
- 탭바는 아이폰에서는 5개까지 가능
