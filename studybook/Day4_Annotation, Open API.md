# Day4_Annotation, Open API

생성일: 2021년 9월 30일 오전 10:19

## 1. Custom Annotation

- 핀 뷰에 이미지 추가하기
    
    ```swift
    let image = UIImage(named: "disney")
    let imageView = UIImageView(image: image)
    imageView.frame.size = CGSize(width: 60, height: 40)
    pinView.leftCalloutAccessoryView = imageView
    ```
    

- 핀 뷰에 버튼 추가하기
    
    ```swift
    let button = UIButton(type: .detailDisclosure)
    pinView.rightCalloutAccessoryView = button
    ```
    

- delegate 지정
    - 프로토콜 추가 : `MKMapViewDelegate`
    - 연결 : `mapView.delegate = self`
    

![스크린샷 2021-09-30 오전 10.51.27.png](https://github.com/mingging/ios_dev_course_2021_p2/blob/master/studybook/md_images/Day4_image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-30_%EC%98%A4%EC%A0%84_10.51.27.png)

- 전체 코드
    
    ```swift
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
       guard let myAnnotation = annotation as? MyAnnotation else {
         return nil
       }
    
       let pinView = MKPinAnnotationView(annotation: myAnnotation, reuseIdentifier: "pin")
       pinView?.canShowCallout = true
                
       if let imageName = myAnnotation.thumbNail {
           let image = UIImage(named:imageName)
           let imageView = UIImageView(image: image)
           imageView.frame.size = CGSize(width: 60, height: 40)
           pinView?.leftCalloutAccessoryView = imageView
       }     
                
       let button = UIButton(type: .detailDisclosure)
       pinView?.rightCalloutAccessoryView = button
            
       return pinView
    }
    ```
    
- 재활용하기
    - `dequeueReusableAnnotationView`
    
    ```swift
    if let tempView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") {
       pinView = tempView
       // 타이틀과 서브타이틀을 넣는다.
       pinView?.annotation = myAnnotation
    
       let imageView = pinView?.leftCalloutAccessoryView as? UIImageView
       if let imageName = myAnnotation.thumbNail {
             let image = UIImage(named: imageName)
             imageView?.image = image
       }
    }
    ```
    
- 버튼 누르면 링크 이동하기
    - 버튼 이동하는 순간을 알려주는 메서드 : `calloutAccessoryControlTapped`
    - mapURL의 값은 MyAnnotation에게 있기 때문에 형변환
        - `let myAnnotation = view.annotation as? MyAnnotation`
    - 언래핑하기
    
    - view controller 추가 후 storyboadID 설정
    - DetailViewController Class 생성
        
        import WebKit
        
    
    - 스토리보드 아이디로 두개 뷰 연결
    - DetailViewController로 형변환
        
        ```swift
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "detail") as? DetailViewController else {return}
        
        viewController.strURL = url
        self.present(viewController, animated: true)
        ```
        
    
    - 웹뷰 불러오기
        
        ```swift
        guard let link = strURL,
        		let url = URL(string: link)
        else {return}
        let request = URLRequest(url: url)
        webView.load(request)
        ```
        

## 2. Open API

Application Programming Interface

- API의 역할

![스크린샷 2021-09-30 오전 11.45.33.png](https://github.com/mingging/ios_dev_course_2021_p2/blob/master/studybook/md_images/Day4_image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-30_%EC%98%A4%EC%A0%84_11.45.33.png)

- Open API는 서비스, 정보, 데이터 등 언제, 어디서 누구나 쉽게 이용할 수 있도록 개방된 API를 의미
- 통신망의 구조 및 기술에 독립적으로 새로운 응용 서비스를 쉽게 개발할 수 있도록 한다.
- 주로 웹서비스 형태로 제공된다.

- json (Javascript object notation)

### 실습) API를 이용한 책 검색

- URLSession
    - HTTP/HTTPS 프로토콜을 통해 데이터를 가져오거나 파일을 업로드, 다운로드 하는 기능을 제공하는 클래스
    - 앱이 실행 중이지 않거나 일시 중단된 동안 백그라운드 작업을 통해 데이터를 다운로드하는 것도 가능
    - URLSession은 실제 작업을 수행하는 하나 이상의 Task를 생성
    - Task의 종류
        - URLSessionDataTask : 서버에 데이터를 검색하는 HTTP GET 요청에 사용
        - URLSessionUploadTask : HTTP POST, PUT 메소드를 통해서 디스크에스 웹서버로 파일을 전송시 사용
        - URLSessionDownloadTask : 서버에서 파일을 다운로드할 때 사용

- Request
    - URL
    
    ```
    GET /v3/search/book HTTP/1.1
    Host: dapi.kakao.com
    Authorization: KakaoAK {REST_API_KEY}
    ```
    
    - parameter
    
    ![스크린샷 2021-09-30 오후 12.35.37.png](https://github.com/mingging/ios_dev_course_2021_p2/blob/master/studybook/md_images/Day4_image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-30_%EC%98%A4%ED%9B%84_12.35.37.png)
    
- 프로젝트 생성
    - navigation controller, tableView, ,view contoller, webkit view 생성
    - UITableViewController 상속, MainTableViewController Class 생성 후 연결
    - UIViewController 상속,  DetailViewController Class 생성 후 연결

- 데이터 가져오기 위해 설정하기
    - shared : singletone
    
    session은 연결만 해주고 실제는 Task가 동작
    
    - `session.dataTask(with: URLRequest, completionHandler: (Data?, URLResponse?, Error?) → Void)`
    - `resume` 으로 불러오기
    
    ```swift
    func search() {
        let strURL = "https://dapi.kakao.com/v3/search/book?query=ios"
        guard let url = URL(string: strURL) else {return}
        var request = URLRequest(url: url)
        // 헤더 추가
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        // 방식 설정
        request.httpMethod = "GET"
        // 세션 설정
        let session = URLSession.shared
        // 테스크 생성
        let dataTask = session.dataTask(with: request, completionHandler: dataTaskHandler)
            
        dataTask.resume()
    }
    ```
    
     
    
- 데이터 가져오기
    - json 형식으로 가져오기
        - `JSONSerialization.jsonObject(with: Data, options: JSONSerializtion.ReadingOptions)`
    - 갚 사용하기
    
    ```swift
    let meta = dic["meta"] as? [String:Any]
    books = dic["documents"] as? [[String:Any]]
    ```
    
- 테이블 뷰 다시 불러오기

- thread : 일을 하는 단위
- `DispatchQueue.main.async`
    - 테스크마다 일할 것들을 줄 세워놓는다.

- tableView에 세팅하기
    - books 값 가져오기
        
        ```swift
        guard let books = self.books else {return cell}
        let book = books[indexPath.row]
        ```
        
    - 타이틀 세팅
        
        ```swift
        let bookTitle = cell.viewWithTag(1) as? UILabel
        bookTitle?.text = book["title"] as? String
        ```
        
- 검색값으로 쿼리 넘기기
    - seachBar 추가
    - delegate protocol 추가
    - `seachBar.delegate = self`
    - search 함수 수정
        - 매개변수 추가 →  `query: String, page: Int`
        - url 수정 → `?query=\(query)&page=\(page)`
    - query값과 page 값을 넘겨주기
    
    ```swift
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       guard let query = searchBar.text else {return}
       search(query: query, page: 1)
       // 키보드 내리기
       seachBar.resignFirstResponder()       
    }
    ```
    

- 검색 값 한글 처리하기
    - url + `as NSString`
    - `addingPercentEncoding(withAllowedCharacters: CharacterSet)`
    - 아래와 같이 encoding 해준다.
        
        ```
        // encoding 안했을 때
        https://dapi.kakao.com/v3/search/book?query=안녕&page=1
        // encoding 했을 때
        https://dapi.kakao.com/v3/search/book?query=%EC%95%88%EB%85%95&page=1
        ```
        
- 페이지 관리하기
    - barItemButton 추가
    - action 연결
    - 다음 버튼
        
        ```swift
        // 다음 버튼
            @IBAction func actNext(_ sender: UIBarButtonItem) {
                page += 1
                guard let query = searchBar.text else {return}
                search(query: query, page: page)
            }
        ```
        
    - 이전 버튼
        
        ```swift
        // 이전 버튼
            @IBAction func actPrev(_ sender: UIBarButtonItem) {
                if (page > 0) {
                    page -= 1
                } else {
                    page = 0
                }
                guard let query = searchBar.text else {return}
                search(query: query, page: page)
            }
        ```
        

- 이미지 추가하기
    - `let imageURL = book["thumbnail"]`
    - 이미지 다운로드 받기
        - `Data(contentsOf: url)`
    
    ```swift
    if let imageURL = book["thumbnail"] as? String,  let url = URL(string: imageURL) {
       // 이미지 다운로드
       do {
           let data = try Data(contentsOf: url)
           let thumbNail = cell.viewWithTag(2) as? UIImageView
           thumbNail?.image = UIImage(data: data)
       } catch {print("thumbnail download failed")}
               
    }
    ```
    

- (숙제) author 출력해오기

- webView 띄우기
    - 데이터 넘겨주기
        
        ```swift
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let destVC = segue.destination as? DetailViewController,
        			   let indexPath = tableView.indexPathForSelectedRow,
                 let books = self.books
           else {return}
                
           let book = books[indexPath.row]
                
           destVC.strURL = book["url"] as? String
        }
        ```
        
    - 받은 데이터로 웹뷰에 띄우기
        
        ```swift
        guard let str = strURL,
              let url = URL(string: str)
        else {return}
                
        let request = URLRequest(url: url)
        webView.load(request)
        ```
