# Day3_Alert, ImagePicker, WebView

생성일: 2021년 9월 29일 오전 10:06

## 1. AlertViewController

### 1. AlertView

![스크린샷 2021-09-29 오전 10.07.20.png](https://github.com/minimanin/ios_dev_course_2021_p2/blob/master/studybook/md_images/Day3_image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-29_%EC%98%A4%EC%A0%84_10.07.20.png)

- 아이폰은 취소가 앞에 있다.

- Button Action 추가하기
    - Connection
        - Outlet Conllection : 아웃렛을 여러개 연결한다.
    - Object : 메소드가 포함된 클래스
    - Type : sender의 타입 지정
        - sender : 이벤트를 발생시킨 요소
        - Any 타입으로 지정하면 따로 형변환을 시켜줘야한다.
            - sender의 타입에 따라 조건문을 작성할 수 있다.
    - Argument : 매개변수를 쓰지 않을거면 None

Any : 모든 타입의 레퍼런스를 받을 수 있다.

- Alert 띄우기
    - `UIAlertController(title: String?, message: String?, preferredStyle: UIAlertController.Style)`
        - preferredStyle (Enum) : ActionSheet Style과 Alert Style 중 고를 수 있다.
    - `present(viewControllerToPresent: UIViewController, animated: Bool, completion: (() → Void)?)`
        - UIViewController
        - completion : alert 뷰가 보였을 때 동작할 메서드
    - Alert의 Action을 만들어서 추가해줘야한다.

- Alert Action 만들기
    - `UIAlertAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) → Void)?)`
        - style : 확인, 취소, 삭제 style 지정
        - handler : 버튼을 클릭했을 때 동작할 메서드
        
- Action 추가하기
    - `alert.addAction(action: UIAlertAction)`

```swift
let alert = UIAlertController(title: "Title", message: "message message", preferredStyle: .alert)
        
let action1 = UIAlertAction(title: "확인", style: .default, handler: nil)
alert.addAction(action1)
present(alert, animated: true, completion: nil)
```

AlertController는 틀이고 실제 동작은 Action이 한다.

- completion 만들기
    - 함수 만들기
    - 타입은 Void 타입, 매개변수 없음
    
    ```swift
    func afterPresent() {
      print("after present alert")
    }
    ```
    
- handler 만들기
    - 함수 만들기
    - 타입은 Void 타입, 매개변수 UIAlertAction 타입
    
    ```swift
    func afterAction(action: UIAlertAction) {
      print(action)
    }
    ```
    
    - 다른 모양으로도 만들 수 있음
    
    ```swift
    let action4 = UIAlertAction(title: "후행클로져", style: .default) { action in
        print("action4")
    }
    ```
    

### 2. ActionSheet

![스크린샷 2021-09-29 오전 10.08.38.png](https://github.com/minimanin/ios_dev_course_2021_p2/blob/master/studybook/md_images/Day3_image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-29_%EC%98%A4%EC%A0%84_10.08.38.png)

ActionView와 ActionSheet는 원래 나뉘어져 있었는데 합쳐졌다.

## 2. UIImagePickerController

- 버튼 눌러 ImagePicker 가져오기
    - `let picker = UIImagePickerController()`
        - ImagePickerController 선언
        
- 부르기
    - `present(picker, animated: true)`

![스크린샷 2021-09-29 오전 11.46.45.png](https://github.com/minimanin/ios_dev_course_2021_p2/blob/master/studybook/md_images/Day3_image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-29_%EC%98%A4%EC%A0%84_11.46.45.png)

- 속성 추가하기
    - `picker.sourceType = .camera`
        - camera
        - photoLibrary
        - savedPhotosAlbum
    - camera는 시뮬레이터에서 실행하면 터진다.
    - 권한을 설정해줘야한다.
    
- (카메라 사용시!) 권한 설정하기
    - info.plist에 row 추가
        - Privacy - Camera Usage Description
        - Privacy - Photo Library Usage Description
    - 거부했을 경우 앱을 사용할 수 없다는 문구를 띄워야한다.
    
- Delegate 추가하기
    - 프로토콜 추가
        - `UIImagePickerControllerDelegate`
        - `UINavigationControllerDelegate`
            - 화면 전환하는 과정에서 필요하다.
    - 이미지 가져오기
    
    ```swift
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       guard let image = info[.originalImage] as? UIImage else {return}
            
       imageView.image = image
            
       dismiss(animated: true)
    }
    ```
    
    dismiss를 써줘야 닫힌다.
    

### 실습) Alert과 ImagePicker 사용하기

- alert창에 촬영하기와 이미지 불러오기 선택지를 주고 각 선택지에 따른 결과를 반환하자

```swift
let alert = UIAlertController(title: "이미지", message: "촬영하기와 이미지 불러오기 중 선택해주세요", preferredStyle: .alert)
let cameraAction = UIAlertAction(title: "촬영하기", style: .default) { _ in
    self.picker.sourceType = .camera
    self.present(self.picker, animated: true)

}

        
let photoLibraryAction = UIAlertAction(title: "이미지 불러오기", style: .default) { _ in
    self.picker.sourceType = .photoLibrary
    self.present(self.picker, animated: true)
}
        
alert.addAction(cameraAction)
alert.addAction(photoLibraryAction)
present(alert, animated: true)
```

## 3. WKWebView

![스크린샷 2021-09-29 오후 2.41.22.png](https://github.com/minimanin/ios_dev_course_2021_p2/blob/master/studybook/md_images/Day3_image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-29_%EC%98%A4%ED%9B%84_2.41.22.png)

- 주소로부터 요청을 받고 서버는 응답을 전달해줌
- Request를 만들어서 보낸다.
- Request에는 주소 정보가 들어있어야한다.

import WebKit

- 주소가 http일 경우
    - App Transport Security Setting의 Allow Arbitrary Loads를 YES로 설정

```swift
guard let url = URL(string: link) else {return}
let request = URLRequest(url: url)
        
webView.load(request)
```

### 실습) 버튼으로 웹뷰 이동하기

- 깃 링크 연결

### 4. MapView

import MapKit

- Frameworks, Libraries, and Embedded Content
    - 여기에서 MapKit.framework를 추가해준다.
    
    ![스크린샷 2021-09-29 오후 3.33.51.png](https://github.com/minimanin/ios_dev_course_2021_p2/blob/master/studybook/md_images/Day3_image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-29_%EC%98%A4%ED%9B%84_3.33.51.png)
    
- location과 span이 결정되야한다.

- 위치 구하기
    - location 구하기
        - `CLLocationCoordinate2D(latitude: 37.463234, longitude: 126.905716)`
            - latitude : 위도
            - longitude : 경도
    - span 구하기
        - `/MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)`
    - region 구하기
        - `MKCoordinateRegion(center: location, span: span)`

```swift
let location = CLLocationCoordinate2D(latitude: 37.463234, longitude: 126.905716)
let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        
let region = MKCoordinateRegion(center: location, span: span)
        
mapView.setRegion(region, animated: true)
```

span에 따라서 default 지도의 크기를 지정할 수 있다.
숫자가 줄어들수록 확대된다.

- 스타일 변경하기
    - standard : 기본
    - satellite : 위성사진
    - Flyover : 날면서 보이는 것 (비스듬하게) → 한국은 지원 안됨
    - hybrid : standard와 staellite를 오버레이 시킨 것
    

### 실습) segment로 mapType 변경하기

- 깃 링크 연동

- 지도에 핀 찍기
    - `MKPointAnnotation()`
    - 마크의 좌표 잡기
        - `mark.coordinate`
    - mapView에 추가하기
        - `mapView.addAnnotation(mark)`
        
- customAnnotation 만들기
    - customAnnotation 클래스 선언
        - NSObject 상속
    - 프로퍼티 연결
        - `MKAnnotation`
