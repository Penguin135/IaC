# 생성되는 리소스
- Key Pair
- EC2 (ubuntu 18.04, t2.micro)
- Security group(inboud:22)
- RDS (MySQL)

# 실습 진행에 참고한 사이트
- https://www.44bits.io/ko/post/terraform_introduction_infrastrucute_as_code
- https://honglab.tistory.com/114

# 주의사항
- 인스턴스에서 RDS에 접속이 안될 수가 있다. 이럴때는 보안그룹에 3306 포트를 inboud 규칙에 추가해 주어야 한다.