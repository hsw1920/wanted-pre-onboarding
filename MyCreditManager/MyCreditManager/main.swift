//
//  main.swift
//  MyCreditManager
//
//  Created by 홍승완 on 2022/11/16.
//

import Foundation


// 학생 class
class Students {
    var name: String
    var subjects: [String:String] = [:]
    init(name: String) {
        self.name = name
    }
}

// 학생 class 리스트
var studentList: [String:Students] = [:]
var quit : Bool = false

// MARK: - 학생 추가
func addStudent(){
    print("추가할 학생의 이름을 입력해주세요")

    let input = readLine()!
    
    // 잘못된 입력 들어오면 처리
    // 잘못된 입력케이스 -> "" 아무런 입력이 없는경우
    if input == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요")
        return
    }
    
    // studentList에서 해당 학생이 존재하는지 여부
    let hasStudentName = studentList.contains { (key: String, value: Students) in
        if key == input {
            return true
        } else {
            return false
        }
    }
    
    // 학생이 이미 존재하면 추가하지 않고 리턴
    if hasStudentName {
        print("\(input)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        return
    }
    
    // 입력 올바르면 dictionary에 추가
    studentList[input] = Students(name: input)
    print("\(input) 학생을 추가했습니다.")
}

// MARK: - 학생 삭제
func deleteStudent(){
    print("삭제할 학생의 이름을 입력해주세요")

    let input = readLine()!
    
    // studentList에서 해당 학생이 존재하는지 여부
    let hasStudentName = studentList.contains { (key: String, value: Students) in
        if key == input {
            return true
        } else {
            return false
        }
    }
    
    // 존재하면 삭제
    if hasStudentName {
        studentList.removeValue(forKey: input)
        print("\(input) 학생을 삭제하였습니다.")
    } else {
        print("\(input) 학생을 찾지 못했습니다.")
    }

}

// MARK: - 성적추가
func addSubject(){
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰길 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    let input = readLine()!
    let studentName: String
    let subject: String
    let subjectScore: String
    
    // 먼저 input으로 들어온 문자열을 공백을 기준으로 나누어서 name subject score로 저장함
    let splitInput = input.split(separator: " ")
    
    // 잘못입력하는 경우?
    // 1. 3가지가 아닌경우
    // 2. 학생이 이름이 없는경우
    
    // 공백기준 3가지 입력이 아닌경우
    if splitInput.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    } else {
        studentName = String(splitInput[0])
        subject = String(splitInput[1])
        subjectScore = String(splitInput[2])
    }
    
    // studentList에서 해당 학생이 존재하는지 여부
    let hasStudentName = studentList.contains { (key: String, value: Students) in
        if key == studentName {
            return true
        } else {
            return false
        }
    }
    
    // 학생이름 없으면 리턴
    if !hasStudentName {
        print("\(studentName) 학생을 찾지 못했습니다.")
        return
    }
    
    // 성적이 잘못 입력되면 리턴
    let Scores = ["A+","A","B+","B","C+","C","D+","D","F"]
    let correctScore = Scores.contains(subjectScore)
    if !correctScore {
        print("성적 입력이 올바르지 않습니다.")
        return
    }
    
    studentList[studentName]?.subjects[subject] = subjectScore
    print("\(studentName) 학생의 \(subject) 과목이 \(subjectScore)로 추가(변경)되었습니다.")
    print("\(studentList[studentName]!.subjects)")
}

// MARK: - 성적삭제
func deleteSubject() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰길 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    
    let input = readLine()!
    let studentName: String
    let subject: String
    
    // 먼저 input으로 들어온 문자열을 공백을 기준으로 나누어서 name subject score로 저장함
    let splitInput = input.split(separator: " ")
    
    // 잘못입력하는 경우?
    // 1. 2가지가 아닌경우
    // 2. 학생이 이름이 없는경우
    
    // 공백기준 2가지 입력이 아닌경우
    if splitInput.count != 2 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    } else {
        studentName = String(splitInput[0])
        subject = String(splitInput[1])
    }
    
    // studentList에서 해당 학생이 존재하는지 여부
    let hasStudentName = studentList.contains { (key: String, value: Students) in
        if key == studentName {
            return true
        } else {
            return false
        }
    }

    // 학생이름 없으면 리턴
    if !hasStudentName {
        print("\(studentName) 학생을 찾지 못했습니다.")
        return
    }
    
    // 해당학생에게 해당과목이 있는지 여부 확인
    let hasSubject = studentList[studentName]!.subjects.contains(where: { (key: String, value: String) in
        if key == subject {
            return true
        } else {
            return false
        }
    })
    
    // 해당 과목이 존재하지 않으면
    if !hasSubject {
        print("\(studentName) 학생의 \(subject) 과목의 성적이 존재하지 않습니다.")
        return
    } else { // 해당 과목이 존재하면
        studentList[studentName]?.subjects.removeValue(forKey: subject)
        print("\(studentName) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
        print(studentList[studentName]!.subjects)
        return
    }
    
}

// MARK: - 평점보기
func showGrade() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    
    let input = readLine()!
    
    let studentName: String
    
    // 잘못입력하는 경우?
    // 1. 공백만 친경우
    // 2. 학생이 이름이 없는경우
    
    // 잘못된 입력 들어오면 처리
    // 잘못된 입력케이스 -> "" 아무런 입력이 없는경우
    if input == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요")
        return
    } else {
        studentName = input
    }
    
    // studentList에서 해당 학생이 존재하는지 여부
    let hasStudentName = studentList.contains { (key: String, value: Students) in
        if key == studentName {
            return true
        } else {
            return false
        }
    }
    
    // 학생이름 없으면 리턴
    if !hasStudentName {
        print("\(studentName) 학생을 찾지 못했습니다.")
        return
    }
    
    var score: Double = 0
    let subjectCount = studentList[studentName]!.subjects.count
    let scoreToDouble : [String:Double] = ["A+":4.5, "A":4.0, "B+":3.5, "B":3.0, "C+":2.5, "C":2.0, "D+":1.5,"D":1.0,"F":0]
    
    for subject in studentList[studentName]!.subjects {
        print("\(subject.key): \(subject.value)")
        score += scoreToDouble[subject.value]!
    }
    
    print("평점 : \(String(format: "%.2f", score/Double(subjectCount)))")
    
}

// MARK: - input Cases
func startFunc(_ cases: String){
    
    switch cases{
    case "1" : // 학생 추가
        addStudent()
    case "2" : // 학생 삭제
        deleteStudent()
    case "3" : // 성적추가(변경)
        addSubject()
    case "4" : // 성적삭제
        deleteSubject()
    case "5" : // 평점보기
        showGrade()
    case "X" : // 종료
        quit = true
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}

while(true){
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5:평점보기, X: 종료")
    let inputs = readLine()!
    
    startFunc(inputs)
    
    if quit {
        print("프로그램을 종료합니다...")
        break
    }
}

