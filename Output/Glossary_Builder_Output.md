### Executive Overview

This document provides a complete data dictionary and glossary for the International Baccalaureate (IB) School Data Vault. It includes inventories of all tables, columns, and relationships, as well as identified documentation gaps. The schema is well-defined, following Data Vault 2.0 modeling principles, with clear distinctions between Hubs, Links, and Satellites.

### Table Inventory

| Schema | Table Name | Table Type | Business Description |
|---|---|---|---|
| Ib | HubStudent | Hub | Represents a unique student. |
| Ib | HubTeacher | Hub | Represents a unique teacher. |
| Ib | HubCourse | Hub | Represents a unique course. |
| Ib | HubCourseSection | Hub | Represents a unique section of a course. |
| Ib | HubSchool | Hub | Represents a unique school. |
| Ib | HubAcademicTerm | Hub | Represents a unique academic term. |
| Ib | HubProgramme | Hub | Represents a unique IB programme. |
| Ib | HubAssessment | Hub | Represents a unique assessment. |
| Ib | LnkSectionOffering | Link | Connects a course section with a course, academic term, and school. |
| Ib | LnkSectionTeacher | Link | Assigns a teacher to a course section with a specific role. |
| Ib | LnkStudentProgramme | Link | Associates a student with an IB programme at a school. |
| Ib | LnkEnrollment | Link | Enrolls a student in a course section. |
| Ib | LnkAttendance | Link | Records a student's attendance for a specific course section on a given date and period. |
| Ib | LnkAssessmentResult | Link | Records a student's result for an assessment in a course section. |
| Ib | SatStudentPersonal | Satellite | Stores personal (PII) attributes of a student. |
| Ib | SatStudentAcademic | Satellite | Stores academic attributes of a student. |
| Ib | SatTeacherDetails | Satellite | Stores attributes of a teacher. |
| Ib | SatCourseDetails | Satellite | Stores attributes of a course. |
| Ib | SatCourseSectionDetails | Satellite | Stores attributes of a course section. |
| Ib | SatSchoolDetails | Satellite | Stores attributes of a school. |
| Ib | SatAcademicTermDetails | Satellite | Stores attributes of an academic term. |
| Ib | SatProgrammeDetails | Satellite | Stores attributes of an IB programme. |
| Ib | SatAssessmentDetails | Satellite | Stores attributes of an assessment. |
| Ib | SatEnrollmentDetails | Satellite | Stores details about a student's enrollment in a course section. |
| Ib | SatStudentProgrammeDetails | Satellite | Stores details about a student's IB programme. |
| Ib | SatAttendanceDetails | Satellite | Stores details about a student's attendance. |
| Ib | SatAssessmentResult | Satellite | Stores details about a student's assessment result. |
| Ib | RefAttendanceStatus | Reference | A reference table for attendance status codes. |
| Ib | BvSatAttendanceSummary | Business Vault | A computed satellite that summarizes student attendance for an enrollment. |

### Column Data Dictionary

**HubStudent** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Hash key for the student | binary(32) | PK, HK | |
| StudentBk | Business key for the student (school student ID) | varchar(50) | BK, UQ | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**HubTeacher** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| TeacherHk | Hash key for the teacher | binary(32) | PK, HK | |
| TeacherBk | Business key for the teacher (staff ID) | varchar(50) | BK, UQ | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**HubCourse** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseHk | Hash key for the course | binary(32) | PK, HK | |
| CourseBk | Business key for the course (e.g. MATH-AA-HL) | varchar(50) | BK, UQ | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**HubCourseSection** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseSectionHk | Hash key for the course section | binary(32) | PK, HK | |
| CourseSectionBk | Business key for the course section (SchoolCode||TermCode||CourseCode||SectionCode) | varchar(120) | BK, UQ | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**HubSchool** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SchoolHk | Hash key for the school | binary(32) | PK, HK | |
| SchoolBk | Business key for the school (IB school code) | varchar(20) | BK, UQ | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**HubAcademicTerm** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AcademicTermHk | Hash key for the academic term | binary(32) | PK, HK | |
| AcademicTermBk | Business key for the academic term (e.g. 2025-FALL) | varchar(30) | BK, UQ | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**HubProgramme** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| ProgrammeHk | Hash key for the programme | binary(32) | PK, HK | |
| ProgrammeBk | Business key for the programme (PYP, MYP, DP, CP) | varchar(10) | BK, UQ | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**HubAssessment** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentHk | Hash key for the assessment | binary(32) | PK, HK | |
| AssessmentBk | Business key for the assessment (e.g. MATH-AA-HL-IA, EE, TOK-ESSAY, CAS) | varchar(60) | BK, UQ | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**LnkSectionOffering** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SectionOfferingHk | Hash key for the section offering | binary(32) | PK, HK | |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| CourseHk | Foreign key to HubCourse | binary(32) | FK | HubCourse |
| AcademicTermHk | Foreign key to HubAcademicTerm | binary(32) | FK | HubAcademicTerm |
| SchoolHk | Foreign key to HubSchool | binary(32) | FK | HubSchool |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**LnkSectionTeacher** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SectionTeacherHk | Hash key for the section teacher assignment | binary(32) | PK, HK | |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| TeacherHk | Foreign key to HubTeacher | binary(32) | FK | HubTeacher |
| TeacherRole | Role of the teacher in the section (PRIMARY, CO-TEACHER, SUBSTITUTE) | varchar(20) | | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**LnkStudentProgramme** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentProgrammeHk | Hash key for the student programme association | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| ProgrammeHk | Foreign key to HubProgramme | binary(32) | FK | HubProgramme |
| SchoolHk | Foreign key to HubSchool | binary(32) | FK | HubSchool |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**LnkEnrollment** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Hash key for the enrollment | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**LnkAttendance** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceHk | Hash key for the attendance event | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| AttendanceDate | Date of the attendance event | date | | |
| PeriodNumber | Class period number | tinyint | | |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**LnkAssessmentResult** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentResultHk | Hash key for the assessment result | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| AssessmentHk | Foreign key to HubAssessment | binary(32) | FK | HubAssessment |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| LoadDts | Load date timestamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatStudentPersonal** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Foreign key to HubStudent | binary(32) | PK, FK | HubStudent |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| FirstName | Student's first name | varchar(100) | | |
| MiddleName | Student's middle name | varchar(100) | | |
| LastName | Student's last name | varchar(100) | | |
| PreferredName | Student's preferred name | varchar(100) | | |
| BirthDate | Student's birth date | date | | |
| Gender | Student's gender | char(1) | | |
| Nationality | Student's nationality (ISO 3166-1 alpha-2) | varchar(2) | | |
| NativeLanguage | Student's native language | varchar(50) | | |
| Email | Student's email address | varchar(255) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatStudentAcademic** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Foreign key to HubStudent | binary(32) | PK, FK | HubStudent |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| GradeLevel | Student's grade level (e.g. Grade 11 / Year 12) | varchar(10) | | |
| IbCandidateCode | IB candidate (personal) code | varchar(20) | | |
| EnrollmentStatus | Student's enrollment status (Active, Withdrawn, Graduated) | varchar(20) | | |
| AdmissionDate | Student's admission date | date | | |
| HouseOrHomeroom | Student's house or homeroom | varchar(30) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatTeacherDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| TeacherHk | Foreign key to HubTeacher | binary(32) | PK, FK | HubTeacher |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| FirstName | Teacher's first name | varchar(100) | | |
| LastName | Teacher's last name | varchar(100) | | |
| Email | Teacher's email address | varchar(255) | | |
| Department | Teacher's department | varchar(100) | | |
| IbWorkshopCertified | Whether the teacher is IB workshop certified | bit | | |
| IsActive | Whether the teacher is currently active | bit | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatCourseDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseHk | Foreign key to HubCourse | binary(32) | PK, FK | HubCourse |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| CourseName | Name of the course | varchar(200) | | |
| ProgrammeCode | Code for the IB programme (PYP, MYP, DP, CP) | varchar(10) | | |
| SubjectGroup | DP subject group (1-6) | tinyint | | |
| SubjectArea | Subject area of the course | varchar(100) | | |
| CourseLevel | Level of the course (HL, SL, Standard) | varchar(10) | | |
| LanguageOfInstruction | Language of instruction for the course | varchar(50) | | |
| TeachingHours | Recommended teaching hours (240 HL / 150 SL) | smallint | | |
| IsCore | Whether the course is a core requirement (TOK, EE, CAS) | bit | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatCourseSectionDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | PK, FK | HubCourseSection |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| SectionCode | Code for the course section | varchar(20) | | |
| Room | Room where the section is held | varchar(30) | | |
| SchedulePeriod | Schedule period for the section | varchar(30) | | |
| Capacity | Capacity of the section | smallint | | |
| SectionStatus | Status of the section | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatSchoolDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SchoolHk | Foreign key to HubSchool | binary(32) | PK, FK | HubSchool |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| SchoolName | Name of the school | varchar(200) | | |
| CountryCode | Country code of the school | varchar(2) | | |
| City | City where the school is located | varchar(100) | | |
| TimeZone | Time zone of the school | varchar(50) | | |
| AuthorizedProgrammes | Authorized IB programmes (e.g. PYP,MYP,DP) | varchar(50) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatAcademicTermDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AcademicTermHk | Foreign key to HubAcademicTerm | binary(32) | PK, FK | HubAcademicTerm |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| TermName | Name of the academic term | varchar(50) | | |
| AcademicYear | Academic year (e.g. 2025-2026) | varchar(9) | | |
| StartDate | Start date of the term | date | | |
| EndDate | End date of the term | date | | |
| InstructionalDays | Number of instructional days in the term | smallint | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatProgrammeDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| ProgrammeHk | Foreign key to HubProgramme | binary(32) | PK, FK | HubProgramme |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| ProgrammeName | Name of the IB programme | varchar(100) | | |
| AgeRange | Age range for the programme (3-12, 11-16, 16-19) | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatAssessmentDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentHk | Foreign key to HubAssessment | binary(32) | PK, FK | HubAssessment |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| AssessmentName | Name of the assessment | varchar(200) | | |
| AssessmentType | Type of assessment (IA, EE, TOK, CAS, EXAM, INTERNAL) | varchar(20) | | |
| IsInternal | Whether the assessment is internal | bit | | |
| MaxScore | Maximum possible score for the assessment | decimal(8,2) | | |
| WeightPercent | Weight of the assessment in percentage | decimal(5,2) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatEnrollmentDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Foreign key to LnkEnrollment | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| EnrollmentStatus | Status of the enrollment (Enrolled, Dropped, Completed) | varchar(20) | | |
| CourseLevel | Course level chosen by the student (HL / SL) | varchar(10) | | |
| EnrollDate | Date of enrollment | date | | |
| DropDate | Date the student dropped the course | date | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatStudentProgrammeDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentProgrammeHk | Foreign key to LnkStudentProgramme | binary(32) | PK, FK | LnkStudentProgramme |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| CandidateType | Type of candidate (Diploma, Course candidate) | varchar(30) | | |
| StartDate | Start date of the programme | date | | |
| ExpectedGraduationDate | Expected graduation date | date | | |
| ProgrammeStatus | Status of the student in the programme | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatAttendanceDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceHk | Foreign key to LnkAttendance | binary(32) | PK, FK | LnkAttendance |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| AttendanceStatusCode | Attendance status code (P, A, L, E) | varchar(10) | | RefAttendanceStatus |
| MinutesLate | Number of minutes late | smallint | | |
| AbsenceReason | Reason for absence | varchar(200) | | |
| RecordedBy | Person who recorded the attendance | varchar(100) | | |
| RecordedDts | Timestamp when the attendance was recorded | datetime2(7) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**SatAssessmentResult** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentResultHk | Foreign key to LnkAssessmentResult | binary(32) | PK, FK | LnkAssessmentResult |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| RawScore | Raw score for the assessment | decimal(8,2) | | |
| IbGrade | IB grade (1-7) | tinyint | | |
| PredictedGrade | Predicted IB grade (1-7) | tinyint | | |
| ResultType | Type of result (Predicted, Internal, Moderated, Final) | varchar(20) | | |
| AssessedDate | Date of assessment | date | | |
| AssessedBy | Person who assessed the result | varchar(100) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**RefAttendanceStatus** (Reference)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceStatusCode | Attendance status code (P, A, L, E) | varchar(10) | PK | |
| StatusName | Name of the attendance status | varchar(50) | | |
| IsPresent | Whether the status indicates presence | bit | | |
| IsExcused | Whether the status indicates an excused absence | bit | | |

**BvSatAttendanceSummary** (Business Vault)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Foreign key to LnkEnrollment | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Load date timestamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date timestamp | datetime2(7) | Metadata | |
| DaysPresent | Number of days present | int | | |
| DaysLate | Number of days late | int | | |
| DaysAbsentExcused | Number of excused absence days | int | | |
| DaysAbsentUnexcused | Number of unexcused absence days | int | | |
| AttendancePercent | Attendance percentage | decimal(5,2) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### Relationship Inventory

| Table Name | Column Name | Relationship Type | Referenced Table Name | Referenced Column Name |
|---|---|---|---|---|
| LnkSectionOffering | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| LnkSectionOffering | CourseHk | Foreign Key | HubCourse | CourseHk |
| LnkSectionOffering | AcademicTermHk | Foreign Key | HubAcademicTerm | AcademicTermHk |
| LnkSectionOffering | SchoolHk | Foreign Key | HubSchool | SchoolHk |
| LnkSectionTeacher | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| LnkSectionTeacher | TeacherHk | Foreign Key | HubTeacher | TeacherHk |
| LnkStudentProgramme | StudentHk | Foreign Key | HubStudent | StudentHk |
| LnkStudentProgramme | ProgrammeHk | Foreign Key | HubProgramme | ProgrammeHk |
| LnkStudentProgramme | SchoolHk | Foreign Key | HubSchool | SchoolHk |
| LnkEnrollment | StudentHk | Foreign Key | HubStudent | StudentHk |
| LnkEnrollment | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| LnkAttendance | StudentHk | Foreign Key | HubStudent | StudentHk |
| LnkAttendance | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| LnkAssessmentResult | StudentHk | Foreign Key | HubStudent | StudentHk |
| LnkAssessmentResult | AssessmentHk | Foreign Key | HubAssessment | AssessmentHk |
| LnkAssessmentResult | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| SatStudentPersonal | StudentHk | Foreign Key | HubStudent | StudentHk |
| SatStudentAcademic | StudentHk | Foreign Key | HubStudent | StudentHk |
| SatTeacherDetails | TeacherHk | Foreign Key | HubTeacher | TeacherHk |
| SatCourseDetails | CourseHk | Foreign Key | HubCourse | CourseHk |
| SatCourseSectionDetails | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| SatSchoolDetails | SchoolHk | Foreign Key | HubSchool | SchoolHk |
| SatAcademicTermDetails | AcademicTermHk | Foreign Key | HubAcademicTerm | AcademicTermHk |
| SatProgrammeDetails | ProgrammeHk | Foreign Key | HubProgramme | ProgrammeHk |
| SatAssessmentDetails | AssessmentHk | Foreign Key | HubAssessment | AssessmentHk |
| SatEnrollmentDetails | EnrollmentHk | Foreign Key | LnkEnrollment | EnrollmentHk |
| SatStudentProgrammeDetails | StudentProgrammeHk | Foreign Key | LnkStudentProgramme | StudentProgrammeHk |
| SatAttendanceDetails | AttendanceHk | Foreign Key | LnkAttendance | AttendanceHk |
| SatAssessmentResult | AssessmentResultHk | Foreign Key | LnkAssessmentResult | AssessmentResultHk |
| BvSatAttendanceSummary | EnrollmentHk | Foreign Key | LnkEnrollment | EnrollmentHk |

### Documentation Gaps

*   **Business Definitions:** While the DDL includes comments that provide some context, formal business definitions for some columns are missing and are marked as 'Business definition required' if a definition could not be reasonably inferred.
*   **Unclear Terminology:** Some column names are self-explanatory (e.g., `FirstName`), but others might require additional clarification for a non-technical audience (e.g., `HashDiff`, `RecordSource`).
*   **Missing Business Rules:** The DDL defines the structure and relationships, but does not capture all the underlying business rules (e.g., specific validation rules for data entry).

### Data Profiling Summary

No data profiling results were provided. To enhance this documentation, it is recommended to perform data profiling to identify data quality issues, value distributions, and other insights. The profiling results can then be incorporated into this document.
