Data Domain: Student Management
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| Student | StudentId | STRING | HubStudent | StudentBk | varchar(50) | Direct mapping to student business key. Traceable to glossary metadata. |
| Student | FirstName | STRING | SatStudentPersonal | FirstName | varchar(100) | Direct mapping. |
| Student | MiddleName | STRING | SatStudentPersonal | MiddleName | varchar(100) | Direct mapping. |
| Student | LastName | STRING | SatStudentPersonal | LastName | varchar(100) | Direct mapping. |
| Student | PreferredName | STRING | SatStudentPersonal | PreferredName | varchar(100) | Direct mapping. |
| Student | BirthDate | DATE | SatStudentPersonal | BirthDate | date | Direct mapping. |
| Student | Gender | STRING | SatStudentPersonal | Gender | char(1) | Direct mapping; coded attribute lacks declared reference enforcement per DV-007. |
| Student | Nationality | STRING | SatStudentPersonal | Nationality | varchar(2) | Direct mapping; coded attribute lacks declared reference enforcement per DV-007. |
| Student | NativeLanguage | STRING | SatStudentPersonal | NativeLanguage | varchar(50) | Direct mapping. |
| Student | Email | STRING | SatStudentPersonal | Email | varchar(255) | Direct mapping. Profiling check for email format was NOT_RUN per glossary profiling summary. |
| Student | GradeLevel | STRING | SatStudentAcademic | GradeLevel | varchar(10) | Direct mapping. |
| Student | CandidateCode | STRING | SatStudentAcademic | IbCandidateCode | varchar(20) | Direct mapping; canonical name normalized from source column IbCandidateCode. |
| Student | EnrollmentStatus | STRING | SatStudentAcademic | EnrollmentStatus | varchar(20) | Direct mapping; coded attribute lacks declared reference enforcement per DV-007. |
| Student | AdmissionDate | DATE | SatStudentAcademic | AdmissionDate | date | Direct mapping. |
| Student | HouseOrHomeroom | STRING | SatStudentAcademic | HouseOrHomeroom | varchar(30) | Direct mapping. |
| Student Programme Enrollment | StudentId | STRING | HubStudent | StudentBk | varchar(50) | Transformation: entity requires relationship context via LnkStudentProgramme; StudentId sourced from linked student business key, not stored on the satellite directly. |
| Student Programme Enrollment | ProgrammeCode | STRING | HubProgramme | ProgrammeBk | varchar(10) | Transformation: entity requires relationship context via LnkStudentProgramme; ProgrammeCode sourced from linked programme business key. |
| Student Programme Enrollment | SchoolCode | STRING | HubSchool | SchoolBk | varchar(20) | Transformation: entity requires relationship context via LnkStudentProgramme; SchoolCode sourced from linked school business key. |
| Student Programme Enrollment | CandidateType | STRING | SatStudentProgrammeDetails | CandidateType | varchar(30) | Direct mapping at relationship grain through StudentProgrammeHk. |
| Student Programme Enrollment | ProgrammeStartDate | DATE | SatStudentProgrammeDetails | StartDate | date | Direct mapping; canonical name normalized from source StartDate. |
| Student Programme Enrollment | ExpectedGraduationDate | DATE | SatStudentProgrammeDetails | ExpectedGraduationDate | date | Direct mapping. |
| Student Programme Enrollment | ProgrammeStatus | STRING | SatStudentProgrammeDetails | ProgrammeStatus | varchar(20) | Direct mapping. |

Data Domain: Academic Programme and Curriculum
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| Programme | ProgrammeCode | STRING | HubProgramme | ProgrammeBk | varchar(10) | Direct mapping to programme business key. |
| Programme | ProgrammeName | STRING | SatProgrammeDetails | ProgrammeName | varchar(100) | Direct mapping. |
| Programme | AgeRange | STRING | SatProgrammeDetails | AgeRange | varchar(20) | Direct mapping. |
| Course | CourseCode | STRING | HubCourse | CourseBk | varchar(50) | Direct mapping to course business key. |
| Course | CourseName | STRING | SatCourseDetails | CourseName | varchar(200) | Direct mapping. |
| Course | ProgrammeCode | STRING | SatCourseDetails | ProgrammeCode | varchar(10) | Direct mapping from source attribute, but reviewer flagged structural ambiguity because ProgrammeCode also exists as hub-based relationship context elsewhere; see DV-005. |
| Course | SubjectGroup | INTEGER | SatCourseDetails | SubjectGroup | tinyint | Direct mapping. |
| Course | SubjectArea | STRING | SatCourseDetails | SubjectArea | varchar(100) | Direct mapping. |
| Course | Level | STRING | SatCourseDetails | CourseLevel | varchar(10) | Direct mapping; canonical name normalized from source CourseLevel. Coded attribute lacks declared reference enforcement per DV-007. |
| Course | LanguageOfInstruction | STRING | SatCourseDetails | LanguageOfInstruction | varchar(50) | Direct mapping. |
| Course | RecommendedTeachingHours | INTEGER | SatCourseDetails | TeachingHours | smallint | Direct mapping; canonical name normalized from source TeachingHours. |
| Course | IsCoreRequirement | BOOLEAN | SatCourseDetails | IsCore | bit | Direct mapping; canonical boolean aligned to source bit. |
| Course Section | CourseSectionId | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Direct mapping to course section business key. Reviewer flagged CourseSectionBk as opaque concatenated key (SchoolCode||TermCode||CourseCode||SectionCode); see DV-004. |
| Course Section | SectionCode | STRING | SatCourseSectionDetails | SectionCode | varchar(20) | Direct mapping. |
| Course Section | Room | STRING | SatCourseSectionDetails | Room | varchar(30) | Direct mapping. |
| Course Section | SchedulePeriod | STRING | SatCourseSectionDetails | SchedulePeriod | varchar(30) | Direct mapping. |
| Course Section | Capacity | INTEGER | SatCourseSectionDetails | Capacity | smallint | Direct mapping. |
| Course Section | SectionStatus | STRING | SatCourseSectionDetails | SectionStatus | varchar(20) | Direct mapping. |

Data Domain: Academic Operations
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| School | SchoolCode | STRING | HubSchool | SchoolBk | varchar(20) | Direct mapping to school business key. |
| School | SchoolName | STRING | SatSchoolDetails | SchoolName | varchar(200) | Direct mapping. |
| School | CountryCode | STRING | SatSchoolDetails | CountryCode | varchar(2) | Mapped to source country code because canonical recommender described location but did not specify atomic location attributes beyond school location. |
| School | City | STRING | SatSchoolDetails | City | varchar(100) | Direct mapping. |
| School | TimeZone | STRING | SatSchoolDetails | TimeZone | varchar(50) | Direct mapping. |
| School | AuthorizedProgrammes | STRING | SatSchoolDetails | AuthorizedProgrammes | varchar(50) | Direct mapping, but source is comma-delimited multi-value attribute; parsing/atomic representation required per DV-006. |
| Academic Term | AcademicTermCode | STRING | HubAcademicTerm | AcademicTermBk | varchar(30) | Direct mapping to academic term business key. |
| Academic Term | TermName | STRING | SatAcademicTermDetails | TermName | varchar(50) | Direct mapping. |
| Academic Term | AcademicYear | STRING | SatAcademicTermDetails | AcademicYear | varchar(9) | Direct mapping. |
| Academic Term | StartDate | DATE | SatAcademicTermDetails | StartDate | date | Direct mapping. |
| Academic Term | EndDate | DATE | SatAcademicTermDetails | EndDate | date | Direct mapping. |
| Academic Term | InstructionalDays | INTEGER | SatAcademicTermDetails | InstructionalDays | smallint | Direct mapping. |
| Section Offering | CourseSectionId | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Transformation: relationship context derived through LnkSectionOffering using CourseSectionHk; section key is opaque concatenation per DV-004. |
| Section Offering | CourseCode | STRING | HubCourse | CourseBk | varchar(50) | Transformation: relationship context derived through LnkSectionOffering using CourseHk. |
| Section Offering | AcademicTermCode | STRING | HubAcademicTerm | AcademicTermBk | varchar(30) | Transformation: relationship context derived through LnkSectionOffering using AcademicTermHk. |
| Section Offering | SchoolCode | STRING | HubSchool | SchoolBk | varchar(20) | Transformation: relationship context derived through LnkSectionOffering using SchoolHk. |
| Teacher | TeacherId | STRING | HubTeacher | TeacherBk | varchar(50) | Direct mapping to teacher business key. |
| Teacher | FirstName | STRING | SatTeacherDetails | FirstName | varchar(100) | Direct mapping. |
| Teacher | LastName | STRING | SatTeacherDetails | LastName | varchar(100) | Direct mapping. |
| Teacher | Email | STRING | SatTeacherDetails | Email | varchar(255) | Direct mapping. Profiling check for email format was NOT_RUN per glossary profiling summary. |
| Teacher | Department | STRING | SatTeacherDetails | Department | varchar(100) | Direct mapping. |
| Teacher | CertificationStatus | BOOLEAN | SatTeacherDetails | IbWorkshopCertified | bit | Direct mapping; canonical certification status aligned to IB workshop certification flag. |
| Teacher | ActiveStatus | BOOLEAN | SatTeacherDetails | IsActive | bit | Direct mapping; canonical active status aligned to source bit. |
| Section Teacher Assignment | CourseSectionId | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Transformation: relationship context derived through LnkSectionTeacher using CourseSectionHk; section key composition opaque per DV-004. |
| Section Teacher Assignment | TeacherId | STRING | HubTeacher | TeacherBk | varchar(50) | Transformation: relationship context derived through LnkSectionTeacher using TeacherHk. |
| Section Teacher Assignment | TeacherRole | STRING | LnkSectionTeacher | TeacherRole | varchar(20) | Direct mapping at link level. |

Data Domain: Enrollment Management
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| Course Enrollment | StudentId | STRING | HubStudent | StudentBk | varchar(50) | Transformation: relationship context derived through LnkEnrollment using StudentHk. Reviewer noted link uniqueness risk if hash generation is inconsistent; see DV-003. |
| Course Enrollment | CourseSectionId | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Transformation: relationship context derived through LnkEnrollment using CourseSectionHk. Reviewer noted link uniqueness risk and opaque key composition; see DV-003 and DV-004. |
| Course Enrollment | EnrollmentStatus | STRING | SatEnrollmentDetails | EnrollmentStatus | varchar(20) | Direct mapping at enrollment grain. |
| Course Enrollment | SelectedCourseLevel | STRING | SatEnrollmentDetails | CourseLevel | varchar(10) | Direct mapping; canonical name normalized from source CourseLevel. |
| Course Enrollment | EnrollmentDate | DATE | SatEnrollmentDetails | EnrollDate | date | Direct mapping; canonical name normalized from source EnrollDate. |
| Course Enrollment | DropDate | DATE | SatEnrollmentDetails | DropDate | date | Direct mapping. |

Data Domain: Attendance Management
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| Attendance Event | StudentId | STRING | HubStudent | StudentBk | varchar(50) | Transformation: relationship context derived through LnkAttendance using StudentHk. Reviewer noted link uniqueness risk at StudentHk+CourseSectionHk+AttendanceDate+PeriodNumber grain; see DV-003. |
| Attendance Event | CourseSectionId | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Transformation: relationship context derived through LnkAttendance using CourseSectionHk. Opaque concatenated key per DV-004. |
| Attendance Event | AttendanceDate | DATE | LnkAttendance | AttendanceDate | date | Direct mapping at link grain. |
| Attendance Event | PeriodNumber | INTEGER | LnkAttendance | PeriodNumber | tinyint | Direct mapping at link grain. |
| Attendance Event | AttendanceStatusCode | STRING | SatAttendanceDetails | AttendanceStatusCode | varchar(10) | Direct mapping, but reviewer confirmed missing FK to RefAttendanceStatus; see DV-002. |
| Attendance Event | MinutesLate | INTEGER | SatAttendanceDetails | MinutesLate | smallint | Direct mapping. |
| Attendance Event | AbsenceReason | STRING | SatAttendanceDetails | AbsenceReason | varchar(200) | Direct mapping. |
| Attendance Event | RecordedBy | STRING | SatAttendanceDetails | RecordedBy | varchar(100) | Direct mapping. |
| Attendance Event | RecordedDateTime | DATETIME | SatAttendanceDetails | RecordedDts | datetime2(7) | Direct mapping; canonical name normalized from source RecordedDts. |
| Attendance Status | AttendanceStatusCode | STRING | RefAttendanceStatus | AttendanceStatusCode | varchar(10) | Direct mapping to reference code. |
| Attendance Status | StatusName | STRING | RefAttendanceStatus | StatusName | varchar(50) | Direct mapping. |
| Attendance Status | IsPresent | BOOLEAN | RefAttendanceStatus | IsPresent | bit | Direct mapping. |
| Attendance Status | IsExcused | BOOLEAN | RefAttendanceStatus | IsExcused | bit | Direct mapping. |
| Attendance Summary | Unresolved | Unresolved | Unresolved | Unresolved | Unresolved | Unresolved: Canonical recommender defines summary for a student's course enrollment, but no canonical attributes beyond examples were supplied. Source Business Vault table BvSatAttendanceSummary contains DaysPresent, DaysLate, DaysAbsentExcused, DaysAbsentUnexcused, and AttendancePercent, yet attribute-level canonical mapping cannot be fully established without explicit canonical attribute list. |

Data Domain: Assessment and Achievement
| Canonical Table Name | Column Name | Data Type | Data Vault Table Name | Data Vault Column Name | Data Type | Remarks |
|---|---|---|---|---|---|---|
| Assessment | AssessmentCode | STRING | HubAssessment | AssessmentBk | varchar(60) | Direct mapping to assessment business key. |
| Assessment | AssessmentName | STRING | SatAssessmentDetails | AssessmentName | varchar(200) | Direct mapping. |
| Assessment | AssessmentType | STRING | SatAssessmentDetails | AssessmentType | varchar(20) | Direct mapping; coded attribute lacks declared reference enforcement per DV-007. |
| Assessment | IsInternal | BOOLEAN | SatAssessmentDetails | IsInternal | bit | Direct mapping. |
| Assessment | MaximumScore | DECIMAL | SatAssessmentDetails | MaxScore | decimal(8,2) | Direct mapping; canonical name normalized from source MaxScore. |
| Assessment | WeightPercentage | DECIMAL | SatAssessmentDetails | WeightPercent | decimal(5,2) | Direct mapping; canonical name normalized from source WeightPercent. |
| Assessment Result | StudentId | STRING | HubStudent | StudentBk | varchar(50) | Transformation: relationship context derived through LnkAssessmentResult using StudentHk. Reviewer noted link uniqueness risk at StudentHk+AssessmentHk+CourseSectionHk grain; see DV-003. |
| Assessment Result | AssessmentCode | STRING | HubAssessment | AssessmentBk | varchar(60) | Transformation: relationship context derived through LnkAssessmentResult using AssessmentHk. |
| Assessment Result | CourseSectionId | STRING | HubCourseSection | CourseSectionBk | varchar(120) | Transformation: relationship context derived through LnkAssessmentResult using CourseSectionHk. Opaque concatenated key per DV-004. |
| Assessment Result | RawScore | DECIMAL | SatAssessmentResult | RawScore | decimal(8,2) | Direct mapping. |
| Assessment Result | IbGrade | INTEGER | SatAssessmentResult | IbGrade | tinyint | Direct mapping. |
| Assessment Result | PredictedGrade | INTEGER | SatAssessmentResult | PredictedGrade | tinyint | Direct mapping. |
| Assessment Result | ResultType | STRING | SatAssessmentResult | ResultType | varchar(20) | Direct mapping; coded attribute lacks declared reference enforcement per DV-007. |
| Assessment Result | AssessmentDate | DATE | SatAssessmentResult | AssessedDate | date | Direct mapping; canonical name normalized from source AssessedDate. |
| Assessment Result | Assessor | STRING | SatAssessmentResult | AssessedBy | varchar(100) | Direct mapping; canonical name normalized from source AssessedBy. |