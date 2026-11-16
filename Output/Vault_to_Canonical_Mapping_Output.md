Data Domain: Student and Academic Participation
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| STUDENT | STUDENT_ID | STRING | HubStudent | StudentBk | varchar(50) | Direct mapping from student business key. |
| STUDENT | FIRST_NAME | STRING | SatStudentPersonal | FirstName | varchar(100) | Direct mapping. |
| STUDENT | MIDDLE_NAME | STRING | SatStudentPersonal | MiddleName | varchar(100) | Direct mapping. |
| STUDENT | LAST_NAME | STRING | SatStudentPersonal | LastName | varchar(100) | Direct mapping. |
| STUDENT | PREFERRED_NAME | STRING | SatStudentPersonal | PreferredName | varchar(100) | Direct mapping. |
| STUDENT | BIRTH_DATE | DATE | SatStudentPersonal | BirthDate | date | Direct mapping. |
| STUDENT | GENDER | STRING | SatStudentPersonal | Gender | char(1) | Direct mapping; canonical STRING mapped from source char(1). |
| STUDENT | NATIONALITY | STRING | SatStudentPersonal | Nationality | varchar(2) | Direct mapping; source uses ISO 3166-1 alpha-2 code. |
| STUDENT | NATIVE_LANGUAGE | STRING | SatStudentPersonal | NativeLanguage | varchar(50) | Direct mapping. |
| STUDENT | EMAIL | STRING | SatStudentPersonal | Email | varchar(255) | Direct mapping. |
| STUDENT | GRADE_LEVEL | STRING | SatStudentAcademic | GradeLevel | varchar(10) | Direct mapping. |
| STUDENT | IB_CANDIDATE_CODE | STRING | SatStudentAcademic | IbCandidateCode | varchar(20) | Direct mapping; glossary notes business definition/documentation gap should be confirmed with stakeholders. |
| STUDENT | ENROLLMENT_STATUS | STRING | SatStudentAcademic | EnrollmentStatus | varchar(20) | Direct mapping. |
| STUDENT | ADMISSION_DATE | DATE | SatStudentAcademic | AdmissionDate | date | Direct mapping. |
| STUDENT | HOUSE_OR_HOMEROOM | STRING | SatStudentAcademic | HouseOrHomeroom | varchar(30) | Direct mapping; glossary identifies business-definition/documentation gap for this term. |
| STUDENT_PROGRAMME_ENROLLMENT | STUDENT_ID | STRING | HubStudent | StudentBk | varchar(50) | Requires traversal through LnkStudentProgramme via StudentHk for business traceability. |
| STUDENT_PROGRAMME_ENROLLMENT | PROGRAMME_CODE | STRING | HubProgramme | ProgrammeBk | varchar(10) | Requires traversal through LnkStudentProgramme via ProgrammeHk. |
| STUDENT_PROGRAMME_ENROLLMENT | SCHOOL_CODE | STRING | HubSchool | SchoolBk | varchar(20) | Requires traversal through LnkStudentProgramme via SchoolHk. |
| STUDENT_PROGRAMME_ENROLLMENT | CANDIDATE_TYPE | STRING | SatStudentProgrammeDetails | CandidateType | varchar(30) | Direct mapping to link satellite attribute. |
| STUDENT_PROGRAMME_ENROLLMENT | START_DATE | DATE | SatStudentProgrammeDetails | StartDate | date | Direct mapping. |
| STUDENT_PROGRAMME_ENROLLMENT | EXPECTED_GRADUATION_DATE | DATE | SatStudentProgrammeDetails | ExpectedGraduationDate | date | Direct mapping. |
| STUDENT_PROGRAMME_ENROLLMENT | PROGRAMME_STATUS | STRING | SatStudentProgrammeDetails | ProgrammeStatus | varchar(20) | Direct mapping. |
| COURSE_ENROLLMENT | STUDENT_ID | STRING | HubStudent | StudentBk | varchar(50) | Requires traversal through LnkEnrollment via StudentHk. |
| COURSE_ENROLLMENT | COURSE_SECTION_ID | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Requires traversal through LnkEnrollment via CourseSectionHk. |
| COURSE_ENROLLMENT | ENROLLMENT_STATUS | STRING | SatEnrollmentDetails | EnrollmentStatus | varchar(20) | Direct mapping. |
| COURSE_ENROLLMENT | COURSE_LEVEL | STRING | SatEnrollmentDetails | CourseLevel | varchar(10) | Direct mapping. |
| COURSE_ENROLLMENT | ENROLL_DATE | DATE | SatEnrollmentDetails | EnrollDate | date | Direct mapping. |
| COURSE_ENROLLMENT | DROP_DATE | DATE | SatEnrollmentDetails | DropDate | date | Direct mapping. |

Data Domain: Academic Structure and Delivery
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| SCHOOL | SCHOOL_CODE | STRING | HubSchool | SchoolBk | varchar(20) | Direct mapping from school business key. |
| SCHOOL | SCHOOL_NAME | STRING | SatSchoolDetails | SchoolName | varchar(200) | Direct mapping. |
| SCHOOL | COUNTRY_CODE | STRING | SatSchoolDetails | CountryCode | varchar(2) | Direct mapping. |
| SCHOOL | CITY | STRING | SatSchoolDetails | City | varchar(100) | Direct mapping. |
| SCHOOL | TIME_ZONE | STRING | SatSchoolDetails | TimeZone | varchar(50) | Direct mapping. |
| SCHOOL | AUTHORIZED_PROGRAMMES | STRING | SatSchoolDetails | AuthorizedProgrammes | varchar(50) | Direct mapping from comma-delimited source text; reviewer issue DV-009 notes structural ambiguity and recommends decomposition/governance rules. |
| ACADEMIC_TERM | ACADEMIC_TERM_CODE | STRING | HubAcademicTerm | AcademicTermBk | varchar(30) | Direct mapping from academic term business key. |
| ACADEMIC_TERM | TERM_NAME | STRING | SatAcademicTermDetails | TermName | varchar(50) | Direct mapping. |
| ACADEMIC_TERM | ACADEMIC_YEAR | STRING | SatAcademicTermDetails | AcademicYear | varchar(9) | Direct mapping. |
| ACADEMIC_TERM | START_DATE | DATE | SatAcademicTermDetails | StartDate | date | Direct mapping. |
| ACADEMIC_TERM | END_DATE | DATE | SatAcademicTermDetails | EndDate | date | Direct mapping. |
| ACADEMIC_TERM | INSTRUCTIONAL_DAYS | INTEGER | SatAcademicTermDetails | InstructionalDays | smallint | Direct mapping; canonical INTEGER mapped from source smallint. |
| PROGRAMME | PROGRAMME_CODE | STRING | HubProgramme | ProgrammeBk | varchar(10) | Direct mapping from programme business key. |
| PROGRAMME | PROGRAMME_NAME | STRING | SatProgrammeDetails | ProgrammeName | varchar(100) | Direct mapping. |
| PROGRAMME | AGE_RANGE | STRING | SatProgrammeDetails | AgeRange | varchar(20) | Direct mapping. |
| COURSE | COURSE_CODE | STRING | HubCourse | CourseBk | varchar(50) | Direct mapping from course business key. |
| COURSE | COURSE_NAME | STRING | SatCourseDetails | CourseName | varchar(200) | Direct mapping. |
| COURSE | PROGRAMME_CODE | STRING | SatCourseDetails | ProgrammeCode | varchar(10) | Direct mapping; reviewer issue DV-008 notes this attribute is not structurally aligned to HubProgramme and may be descriptive only. |
| COURSE | SUBJECT_GROUP | INTEGER | SatCourseDetails | SubjectGroup | tinyint | Direct mapping; canonical INTEGER mapped from source tinyint. |
| COURSE | SUBJECT_AREA | STRING | SatCourseDetails | SubjectArea | varchar(100) | Direct mapping. |
| COURSE | COURSE_LEVEL | STRING | SatCourseDetails | CourseLevel | varchar(10) | Direct mapping. |
| COURSE | LANGUAGE_OF_INSTRUCTION | STRING | SatCourseDetails | LanguageOfInstruction | varchar(50) | Direct mapping. |
| COURSE | TEACHING_HOURS | INTEGER | SatCourseDetails | TeachingHours | smallint | Direct mapping; canonical INTEGER mapped from source smallint. |
| COURSE | IS_CORE | BOOLEAN | SatCourseDetails | IsCore | bit | Direct mapping; canonical BOOLEAN mapped from source bit. |
| COURSE_SECTION | COURSE_SECTION_ID | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Direct mapping from composite section business key. Reviewer issue DV-003 notes this key appears to embed school, term, course, and section context. |
| COURSE_SECTION | SECTION_CODE | STRING | SatCourseSectionDetails | SectionCode | varchar(20) | Direct mapping. |
| COURSE_SECTION | ROOM | STRING | SatCourseSectionDetails | Room | varchar(30) | Direct mapping. |
| COURSE_SECTION | SCHEDULE_PERIOD | STRING | SatCourseSectionDetails | SchedulePeriod | varchar(30) | Direct mapping. |
| COURSE_SECTION | CAPACITY | INTEGER | SatCourseSectionDetails | Capacity | smallint | Direct mapping; canonical INTEGER mapped from source smallint. |
| COURSE_SECTION | SECTION_STATUS | STRING | SatCourseSectionDetails | SectionStatus | varchar(20) | Direct mapping. |
| SECTION_OFFERING | COURSE_SECTION_ID | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Mapped as authoritative section offering identifier; reviewer issue DV-003 notes ambiguity because CourseSectionBk may already encode school, term, course, and section. |
| SECTION_OFFERING | COURSE_CODE | STRING | HubCourse | CourseBk | varchar(50) | Requires traversal through LnkSectionOffering via CourseHk. |
| SECTION_OFFERING | ACADEMIC_TERM_CODE | STRING | HubAcademicTerm | AcademicTermBk | varchar(30) | Requires traversal through LnkSectionOffering via AcademicTermHk. |
| SECTION_OFFERING | SCHOOL_CODE | STRING | HubSchool | SchoolBk | varchar(20) | Requires traversal through LnkSectionOffering via SchoolHk. |
| TEACHER | TEACHER_ID | STRING | HubTeacher | TeacherBk | varchar(50) | Direct mapping from teacher business key. |
| TEACHER | FIRST_NAME | STRING | SatTeacherDetails | FirstName | varchar(100) | Direct mapping. |
| TEACHER | LAST_NAME | STRING | SatTeacherDetails | LastName | varchar(100) | Direct mapping. |
| TEACHER | EMAIL | STRING | SatTeacherDetails | Email | varchar(255) | Direct mapping. |
| TEACHER | DEPARTMENT | STRING | SatTeacherDetails | Department | varchar(100) | Direct mapping. |
| TEACHER | IB_WORKSHOP_CERTIFIED | BOOLEAN | SatTeacherDetails | IbWorkshopCertified | bit | Direct mapping; canonical BOOLEAN mapped from source bit. |
| TEACHER | IS_ACTIVE | BOOLEAN | SatTeacherDetails | IsActive | bit | Direct mapping; canonical BOOLEAN mapped from source bit. |
| SECTION_TEACHER_ASSIGNMENT | COURSE_SECTION_ID | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Requires traversal through LnkSectionTeacher via CourseSectionHk. |
| SECTION_TEACHER_ASSIGNMENT | TEACHER_ID | STRING | HubTeacher | TeacherBk | varchar(50) | Requires traversal through LnkSectionTeacher via TeacherHk. |
| SECTION_TEACHER_ASSIGNMENT | TEACHER_ROLE | STRING | LnkSectionTeacher | TeacherRole | varchar(20) | Direct mapping from link attribute; reviewer issue DV-002 notes mixed-grain design risk because role is stored in the link rather than a link satellite. |

Data Domain: Attendance and Engagement
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| ATTENDANCE_EVENT | STUDENT_ID | STRING | HubStudent | StudentBk | varchar(50) | Requires traversal through LnkAttendance via StudentHk. Reviewer issue DV-004 notes event-grain uniqueness is not explicitly enforced on student, section, date, and period. |
| ATTENDANCE_EVENT | COURSE_SECTION_ID | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Requires traversal through LnkAttendance via CourseSectionHk. Reviewer issue DV-004 notes event-grain uniqueness is not explicitly enforced. |
| ATTENDANCE_EVENT | ATTENDANCE_DATE | DATE | LnkAttendance | AttendanceDate | date | Direct mapping from dependent child attribute in link. |
| ATTENDANCE_EVENT | PERIOD_NUMBER | INTEGER | LnkAttendance | PeriodNumber | tinyint | Direct mapping; canonical INTEGER mapped from source tinyint. |
| ATTENDANCE_EVENT | ATTENDANCE_STATUS_CODE | STRING | SatAttendanceDetails | AttendanceStatusCode | varchar(10) | Direct mapping; reviewer issue DV-007 notes no enforced foreign key to RefAttendanceStatus, so interpretation relies on soft-reference logic. |
| ATTENDANCE_EVENT | MINUTES_LATE | INTEGER | SatAttendanceDetails | MinutesLate | smallint | Direct mapping; canonical INTEGER mapped from source smallint. |
| ATTENDANCE_EVENT | ABSENCE_REASON | STRING | SatAttendanceDetails | AbsenceReason | varchar(200) | Direct mapping. |
| ATTENDANCE_EVENT | RECORDED_BY | STRING | SatAttendanceDetails | RecordedBy | varchar(100) | Direct mapping. |
| ATTENDANCE_EVENT | RECORDED_DTS | TIMESTAMP | SatAttendanceDetails | RecordedDts | datetime2(7) | Direct mapping. |
| ATTENDANCE_STATUS | ATTENDANCE_STATUS_CODE | STRING | RefAttendanceStatus | AttendanceStatusCode | varchar(10) | Direct mapping. |
| ATTENDANCE_STATUS | STATUS_NAME | STRING | RefAttendanceStatus | StatusName | varchar(50) | Direct mapping. |
| ATTENDANCE_STATUS | IS_PRESENT | BOOLEAN | RefAttendanceStatus | IsPresent | bit | Direct mapping; canonical BOOLEAN mapped from source bit. |
| ATTENDANCE_STATUS | IS_EXCUSED | BOOLEAN | RefAttendanceStatus | IsExcused | bit | Direct mapping; canonical BOOLEAN mapped from source bit. |
| ENROLLMENT_ATTENDANCE_SUMMARY | STUDENT_ID | STRING | HubStudent | StudentBk | varchar(50) | Unresolved: summary satellite is keyed by EnrollmentHk and glossary provides no direct stored StudentBk column in BvSatAttendanceSummary; deriving student requires traversal through LnkEnrollment and HubStudent, but no explicit summary-level canonical key is stored. |
| ENROLLMENT_ATTENDANCE_SUMMARY | COURSE_SECTION_ID | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Unresolved: summary satellite is keyed by EnrollmentHk and deriving section requires traversal through LnkEnrollment and HubCourseSection rather than direct storage in Business Vault object. |
| ENROLLMENT_ATTENDANCE_SUMMARY | DAYS_PRESENT | INTEGER | BvSatAttendanceSummary | DaysPresent | int | Direct mapping. Reviewer issue DV-006 notes no HashDiff in this Business Vault satellite; change-tracking behavior should be documented. |
| ENROLLMENT_ATTENDANCE_SUMMARY | DAYS_LATE | INTEGER | BvSatAttendanceSummary | DaysLate | int | Direct mapping. Reviewer issue DV-006 applies. |
| ENROLLMENT_ATTENDANCE_SUMMARY | DAYS_ABSENT_EXCUSED | INTEGER | BvSatAttendanceSummary | DaysAbsentExcused | int | Direct mapping. Reviewer issue DV-006 applies. |
| ENROLLMENT_ATTENDANCE_SUMMARY | DAYS_ABSENT_UNEXCUSED | INTEGER | BvSatAttendanceSummary | DaysAbsentUnexcused | int | Direct mapping. Reviewer issue DV-006 applies. |
| ENROLLMENT_ATTENDANCE_SUMMARY | ATTENDANCE_PERCENT | DECIMAL | BvSatAttendanceSummary | AttendancePercent | decimal(5,2) | Direct mapping. Reviewer issue DV-006 applies. |

Data Domain: Assessment and Academic Performance
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| ASSESSMENT | ASSESSMENT_CODE | STRING | HubAssessment | AssessmentBk | varchar(60) | Direct mapping from assessment business key. |
| ASSESSMENT | ASSESSMENT_NAME | STRING | SatAssessmentDetails | AssessmentName | varchar(200) | Direct mapping. |
| ASSESSMENT | ASSESSMENT_TYPE | STRING | SatAssessmentDetails | AssessmentType | varchar(20) | Direct mapping. |
| ASSESSMENT | IS_INTERNAL | BOOLEAN | SatAssessmentDetails | IsInternal | bit | Direct mapping; canonical BOOLEAN mapped from source bit. |
| ASSESSMENT | MAX_SCORE | DECIMAL | SatAssessmentDetails | MaxScore | decimal(8,2) | Direct mapping. |
| ASSESSMENT | WEIGHT_PERCENT | DECIMAL | SatAssessmentDetails | WeightPercent | decimal(5,2) | Direct mapping. |
| ASSESSMENT_RESULT | STUDENT_ID | STRING | HubStudent | StudentBk | varchar(50) | Requires traversal through LnkAssessmentResult via StudentHk. Reviewer issue DV-005 notes link grain may be too coarse for repeated results. |
| ASSESSMENT_RESULT | ASSESSMENT_CODE | STRING | HubAssessment | AssessmentBk | varchar(60) | Requires traversal through LnkAssessmentResult via AssessmentHk. Reviewer issue DV-005 applies. |
| ASSESSMENT_RESULT | COURSE_SECTION_ID | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Requires traversal through LnkAssessmentResult via CourseSectionHk. Reviewer issue DV-005 applies. |
| ASSESSMENT_RESULT | RAW_SCORE | DECIMAL | SatAssessmentResult | RawScore | decimal(8,2) | Direct mapping. |
| ASSESSMENT_RESULT | IB_GRADE | INTEGER | SatAssessmentResult | IbGrade | tinyint | Direct mapping; canonical INTEGER mapped from source tinyint. |
| ASSESSMENT_RESULT | PREDICTED_GRADE | INTEGER | SatAssessmentResult | PredictedGrade | tinyint | Direct mapping; canonical INTEGER mapped from source tinyint. |
| ASSESSMENT_RESULT | RESULT_TYPE | STRING | SatAssessmentResult | ResultType | varchar(20) | Direct mapping; reviewer issue DV-005 notes this may behave like a business event discriminator not present in the link grain. |
| ASSESSMENT_RESULT | ASSESSED_DATE | DATE | SatAssessmentResult | AssessedDate | date | Direct mapping; reviewer issue DV-005 notes repeated results may be ambiguous under current link grain. |
| ASSESSMENT_RESULT | ASSESSED_BY | STRING | SatAssessmentResult | AssessedBy | varchar(100) | Direct mapping. |