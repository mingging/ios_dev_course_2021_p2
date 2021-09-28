# day2

생성일: 2021년 9월 27일 오전 10:12

[GitHub - minimanin/ios_dev_cource_2021_p2: 모바일 개발자 ios 예제 및 공부 2번째](https://github.com/minimanin/ios_dev_cource_2021_p2)

## 1. iOS Property List

### 1. PList

- new file → Resource → Property List

info.plist : 프로젝트의 설정 관련된 속성

- dictionary 구조
- Root : 최상위
- 넣을 데이터의 구조에 따라 Type을 Array 또는 Dictionary로 지정
- Root의 화살표를 열고 아이템을 만들어야 한다.
- 아이템도 경우에 따라 Type을 지정해서 사용

key = string

![스크린샷 2021-09-28 오전 10.15.42.png](https://github.com/minimanin/ios_dev_course_2021_p2/blob/master/studybook/md_images/day2_images/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-28_%EC%98%A4%EC%A0%84_10.15.42.png)

![스크린샷 2021-09-28 오전 10.24.27.png](https://github.com/minimanin/ios_dev_course_2021_p2/blob/master/studybook/md_images/day2_images/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-28_%EC%98%A4%EC%A0%84_10.24.27.png)

SandBox
내가 만든 앱으로 다른 앱을 제어할 수 없음, 테두리가 쳐져있다. 설치 경로를 알 수 없다.

- [MyApp.app](http://myapp.app) 이라는 패키지(번들)가 설치된다.
    - 우리가 쓰는 컴파일된 앱, 리소스들이 들어있다.
- Documents : 사용자가 쓸 수 있는 폴더

내 앱의 설치경로를 알 수 있는 법

런타임 때 설치경로를 체크해야한다.

- 런타임 때 설치 경로를 가져오기
    - Optional

```swift
Bundle.main.path
```

```
/Users/min/Library/Developer/CoreSimulator/Devices/6A716404-86E6-4744-A809-20D041ADBDB0/data/Containers/Bundle/Application/C8D25432-33DE-4D51-B20C-F0E7586497D5/PListTest.app/bts.plist
```

- `/Users/min/Library/Developer/CoreSimulator/Devices/6A716404-86E6-4744-A809-20D041ADBDB0`
    - 시뮬레이터의 주소
- `data/Containers/Bundle/Application/C8D25432-33DE-4D51-B20C-F0E7586497D5/`
- `C8D25432-33DE-4D51-B20C-F0E7586497D5`
    - 유효 아이디 (랜덤한 숫자)
    - 설치된 경로
    - 보안

삭제하고 설치할 때마다 경로가 다르게 나타난다.

### 2. 경로에서 PList 읽어오기

- `NSArray` : 파운데이션에서 지원, 라이브러리
    - 기본 array도 plist 읽는 방법을 지원하지만 어렵다.
    - NSArray가 조금 더 간단하다.
    - 수정, 삭제, 추가 하며 데이터를 전달할 때 class이기 때문에 참조값만 넘기면 되기 때문에 핸들링이 편하다.
    - 수정 불가능

`NSMutableArray`

- NSArray와 동일하나 수정이 가능하다.

- `contentsOfFile`
    - 파일을 전달한 후 array로 변경할 수 있으면 array로 만들어준다.

 NSArray를 사용할 경우 참조값을 가지고 있기 때문에 형변환을 해줘야한다.

- 패키지를 수정할 수 없다.
- 사용할 수 있는 경로로 복사 후 수정, 삭제, 추가 같은 기능을 사용할 수 있다.

```swift
var bts:NSArray?

override func viewDidLoad() {
  super.viewDidLoad()
        
  if let path = Bundle.main.path(forResource: "bts", ofType: "plist") {
     if let bts = NSArray(contentsOfFile: path) {
         if let member = bts[0] as? [String:String] {
             print(member["stage_name"])
         }
     }
  }
}
```

NS : Next Step
스티브 잡스가 애플에서 쫓겨난 후 새운 회사가 Next Step 이다. 그 때 만든 클래스

### 3. 앱 만들기 (다시 해보기)

- plist 파일에서 내용 불러오기 → ViewDidLoad
    
    ```swift
    guard let path = Bundle.main.path(forResource: "bts", ofType: "plist") else { return }
    bts = NSArray(contentsOfFile: path)
    ```
    
    - bts는 이미 선언을 했기 때문에 또 하지 않아도 된다.

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
if let bts = self.bts {
   if let dic = bts[indexPath.row] as? [String:String] {
      if let imageView = cell.viewWithTag(1) as? UIImageView {
         if let imageName = dic["image"] {
             imageView.image = UIImage(named: imageName)
         }
      }
                
      if let stageName = cell.viewWithTag(2) as? UILabel {
          stageName.text = dic["stage_name"]
      }
                
      if let name = cell.viewWithTag(3) as? UILabel {
         name.text = dic["name"]
      }          
   }
}
```

### 4. PList 수정, 삭제, 추가

![스크린샷 2021-09-28 오후 2.08.56.png](https://github.com/minimanin/ios_dev_course_2021_p2/blob/master/studybook/md_images/day2_images/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-09-28_%EC%98%A4%ED%9B%84_2.08.56.png)

- Document 폴더에 복사한 후 PList를 읽을 때 복사한 list를 읽어야한다.
- 앱이 실행될 때 복사한다. → 최초 한번만 복사해야한다.
    - Documents 폴더에 plist가 있는지 없는지 체크해서 최초 한번 복사

- 복사하기
    - `NSSearchPathForDirctoriesInDomains` : 도메인 안에 있는 폴더들을 가져온다. (가져올 폴더, 용도)
    - 사용자가 쓸 수 있는 documentDirectory는 따로 있다.
    - useDomainMask : 사용자가 쓸 수 있는 document를 가져온다.
    - bar button item으로 navigation bar에 아이템 추가 가능
    - NSString 을 쓰면 `docPath.appendingPathComponent(fileName)` 으로 사용 가능
        - (mac) pathComponent = /
        
        String에서 NSString으로 형변환하는 것은 무조건 성공한다.
        
    - 파일이름 가져오는 함수
        
        ```swift
        func getFileName(_ fileName: String) -> String {
           let docDirs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
           let docPath = docDirs[0] as NSString
           let fullPath = docPath.appendingPathComponent(fileName)
           return fullPath
        }
        ```
        
        - 가져온 결과
        
        ```
        /Users/min/Library/Developer/CoreSimulator/Devices/6A716404-86E6-4744-A809-20D041ADBDB0/data/Containers/Data/Application/658F8495-9FCC-4962-A31B-DEA73C4791B5/Documents/bts.plist
        ```
        
    - 옮길 파일 가져오기
        
        ```swift
        guard let sourcePath = Bundle.main.path(forResource: "bts", ofType: "plist") else {return}
        ```
        
    
    - Documents 폴더에 파일이 있는지 확인
        - `FileManager.default`
            - singleton 객체 : 앱에서 하나만 만들어지는 객체
            - 인스턴스가 있으면 그 인스턴스의 레퍼런스를 넘겨주고 없으면 새로 만들어서 넘겨준다.
            - 한 앱에서 두 개 이상 만들어질 수 없다.
        - `fileManager.fileExists(atPath: targetPath)`
            - 파일이 있는지 없는지 확인
            - 있으면 True, 없으면 False
    
    ```swift
    let targetPath = getFileName("bts.plist")
    guard let sourcePath = Bundle.main.path(forResource: "bts", ofType: "plist") else {return}
            
    let fileManager = FileManager.default
            
    if !fileManager.fileExists(atPath: targetPath) {
       do {
          try fileManager.copyItem(atPath: sourcePath, toPath: targetPath)
       } catch {
          // 예외가 발생했을 때 처리
          print("복사 실패")
       }
    }
    ```
    
    plist 값을 바꾸면 앱을 삭제한 후 다시 깔아야 다시 복사가 된다.
    
- 바뀐 값 저장하기
    - `bts.write(toFile: getFileName("bts.plist"), atomically: true)`
        - atomically : 스레드 관련 내용 어떤 메소드를 동시에 접근할 때 안전성을 보장해준다.

- 수정하기
    - NSMutableArray 이용

- 추가하기
    
    ```swift
    guard let name = txtName.text else {return}
    let newbee = ["stage_name":name]
    bts?.add(newbee)
    bts?.write(toFile: getFileName("bts.plist"), atomically: true)
    ```
    

- 삭제하기
    
    ```swift
    if editingStyle == .delete {
       // Delete the row from the data source
       bts?.removeObject(at: indexPath.row)
       bts?.write(toFile: getFileName("bts.plist"), atomically: true)
       tableView.deleteRows(at: [indexPath], with: .fade)
    }
    ```
    

- 추가한 후 내용 변경
    - 첫번째
        - `viewWillAppear` : ViewDidLoad 다음에 호출되는 함수
            - 여러번 실행된다.
        - `tableView.reloadData()`
        - 필요없을 때도 로드하기 때문에 맞지 않는다.
        
        ```swift
        override func viewWillAppear(_ animated: Bool) {
        	  tableView.reloadData()
        }
        ```
        
    - 두번째
        - **Unwind**
        - 버튼으로만 연결 가능
        
        ```swift
        @IBAction func exitFromAddVC(segue:UIStoryboardSegue) {
           tableView.reloadData()
        }
        ```
