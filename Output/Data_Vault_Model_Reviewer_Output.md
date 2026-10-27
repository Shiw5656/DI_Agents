# Executive Overview

This review was performed using the supplied SQL Server DDL file `IB_datavault 2.sql` and the accessible textual content extracted from `IB_DataVault_Data_Profiling_Plan.xlsx`.

The DDL confirms a Data Vault model containing 8 hubs, 6 links, 13 standard satellites, 1 reference table, and 1 Business Vault satellite. The profiling workbook content available through the file-read tool does not provide executed data-profiling results at row/column level; instead, it documents scope, expected counts, and a key stated design concern: `SatAttendanceDetails.AttendanceStatusCode` has no declared foreign key to `RefAttendanceStatus`.

Because no representative source or vault data extracts were accessible, this review distinguishes:
- **DDL-confirmed findings**: directly supported by the SQL DDL.
- **Profiling-confirmed findings**: supported by the workbook text actually accessible.
- **Inferred risks**: architecture risks reasonably inferred from the design.
- **Validation gaps**: checks that could not be completed due to lack of executable profiling evidence.

# Table Inventory

| Table Name | Object Type | Parent / Grain | Primary Key | Notes |
|---|---|---|---|---|
| Ib.HubStudent | Hub | Student business key | StudentHk | Unique BK index on StudentBk |
| Ib.HubTeacher | Hub | Teacher business key | TeacherHk | Unique BK index on TeacherBk |
| Ib.HubCourse | Hub | Course business key | CourseHk | Unique BK index on CourseBk |
| Ib.HubCourseSection | Hub | Course section business key | CourseSectionHk | BK comment indicates SchoolCode||TermCode||CourseCode||SectionCode |
| Ib.HubSchool | Hub | School business key | SchoolHk | Unique BK index on SchoolBk |
| Ib.HubAcademicTerm | Hub | Academic term business key | AcademicTermHk | Unique BK index on AcademicTermBk |
| Ib.HubProgramme | Hub | Programme business key | ProgrammeHk | Unique BK index on ProgrammeBk |
| Ib.HubAssessment | Hub | Assessment business key | AssessmentHk | Unique BK index on AssessmentBk |
| Ib.LnkSectionOffering | Link | Section offered as course+term+school | SectionOfferingHk | Links CourseSection, Course, AcademicTerm, School |
| Ib.LnkSectionTeacher | Link | Teacher assigned to section | SectionTeacherHk | Includes dependent child attribute TeacherRole in link |
| Ib.LnkStudentProgramme | Link | Student in programme at school | StudentProgrammeHk | Links Student, Programme, School |
| Ib.LnkEnrollment | Link | Student enrolled in section | EnrollmentHk | Links Student and CourseSection |
| Ib.LnkAttendance | Link | Attendance event by student+section+date+period | AttendanceHk | Includes dependent child keys AttendanceDate and PeriodNumber in link |
| Ib.LnkAssessmentResult | Link | Student result for assessment in section | AssessmentResultHk | Links Student, Assessment, CourseSection |
| Ib.SatStudentPersonal | Satellite | Student descriptive / PII | StudentHk + LoadDts | Contains HashDiff, LoadEndDts, RecordSource |
| Ib.SatStudentAcademic | Satellite | Student academic descriptive | StudentHk + LoadDts | Contains candidate code and status |
| Ib.SatTeacherDetails | Satellite | Teacher descriptive | TeacherHk + LoadDts | Contains active/certification flags |
| Ib.SatCourseDetails | Satellite | Course descriptive | CourseHk + LoadDts | Includes ProgrammeCode but no FK |
| Ib.SatCourseSectionDetails | Satellite | Course section descriptive | CourseSectionHk + LoadDts | Contains SectionCode, Room, SchedulePeriod |
| Ib.SatSchoolDetails | Satellite | School descriptive | SchoolHk + LoadDts | Contains AuthorizedProgrammes as delimited text |
| Ib.SatAcademicTermDetails | Satellite | Term descriptive | AcademicTermHk + LoadDts | Contains StartDate and EndDate |
| Ib.SatProgrammeDetails | Satellite | Programme descriptive | ProgrammeHk + LoadDts | Contains ProgrammeName and AgeRange |
| Ib.SatAssessmentDetails | Satellite | Assessment descriptive | AssessmentHk + LoadDts | Contains MaxScore and WeightPercent |
| Ib.SatEnrollmentDetails | Link Satellite | Enrollment descriptive | EnrollmentHk + LoadDts | Contains EnrollmentStatus, dates |
| Ib.SatStudentProgrammeDetails | Link Satellite | Student programme descriptive | StudentProgrammeHk + LoadDts | Contains CandidateType and dates |
| Ib.SatAttendanceDetails | Link Satellite | Attendance descriptive | AttendanceHk + LoadDts | Contains AttendanceStatusCode, timing fields |
| Ib.SatAssessmentResult | Link Satellite | Assessment result descriptive | AssessmentResultHk + LoadDts | Contains RawScore and grades |
| Ib.RefAttendanceStatus | Reference | Attendance status code | AttendanceStatusCode | Seeded with 4 rows in DDL |
| Ib.BvSatAttendanceSummary | Business Vault Satellite | Enrollment attendance summary | EnrollmentHk + LoadDts | Computed summary satellite |

# Column Data Dictionary

| Table Name | Column Name | Data Type | Nullability | Role | Notes |
|---|---|---:|---|---|---|
| Ib.HubStudent | StudentHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.HubStudent | StudentBk | varchar(50) | NOT NULL | Business Key | Unique clustered index |
| Ib.HubStudent | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.HubStudent | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.HubTeacher | TeacherHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.HubTeacher | TeacherBk | varchar(50) | NOT NULL | Business Key | Unique clustered index |
| Ib.HubTeacher | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.HubTeacher | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.HubCourse | CourseHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.HubCourse | CourseBk | varchar(50) | NOT NULL | Business Key | Unique clustered index |
| Ib.HubCourse | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.HubCourse | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.HubCourseSection | CourseSectionHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.HubCourseSection | CourseSectionBk | varchar(120) | NOT NULL | Business Key | Composite BK encoded as text |
| Ib.HubCourseSection | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.HubCourseSection | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.HubSchool | SchoolHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.HubSchool | SchoolBk | varchar(20) | NOT NULL | Business Key | Unique clustered index |
| Ib.HubSchool | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.HubSchool | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.HubAcademicTerm | AcademicTermHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.HubAcademicTerm | AcademicTermBk | varchar(30) | NOT NULL | Business Key | Unique clustered index |
| Ib.HubAcademicTerm | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.HubAcademicTerm | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.HubProgramme | ProgrammeHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.HubProgramme | ProgrammeBk | varchar(10) | NOT NULL | Business Key | Unique clustered index |
| Ib.HubProgramme | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.HubProgramme | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.HubAssessment | AssessmentHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.HubAssessment | AssessmentBk | varchar(60) | NOT NULL | Business Key | Unique clustered index |
| Ib.HubAssessment | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.HubAssessment | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.LnkSectionOffering | SectionOfferingHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.LnkSectionOffering | CourseSectionHk | binary(32) | NOT NULL | FK | To HubCourseSection |
| Ib.LnkSectionOffering | CourseHk | binary(32) | NOT NULL | FK | To HubCourse |
| Ib.LnkSectionOffering | AcademicTermHk | binary(32) | NOT NULL | FK | To HubAcademicTerm |
| Ib.LnkSectionOffering | SchoolHk | binary(32) | NOT NULL | FK | To HubSchool |
| Ib.LnkSectionOffering | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.LnkSectionOffering | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.LnkSectionTeacher | SectionTeacherHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.LnkSectionTeacher | CourseSectionHk | binary(32) | NOT NULL | FK | To HubCourseSection |
| Ib.LnkSectionTeacher | TeacherHk | binary(32) | NOT NULL | FK | To HubTeacher |
| Ib.LnkSectionTeacher | TeacherRole | varchar(20) | NOT NULL | Dependent Child | Role carried in link |
| Ib.LnkSectionTeacher | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.LnkSectionTeacher | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.LnkStudentProgramme | StudentProgrammeHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.LnkStudentProgramme | StudentHk | binary(32) | NOT NULL | FK | To HubStudent |
| Ib.LnkStudentProgramme | ProgrammeHk | binary(32) | NOT NULL | FK | To HubProgramme |
| Ib.LnkStudentProgramme | SchoolHk | binary(32) | NOT NULL | FK | To HubSchool |
| Ib.LnkStudentProgramme | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.LnkStudentProgramme | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.LnkEnrollment | EnrollmentHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.LnkEnrollment | StudentHk | binary(32) | NOT NULL | FK | To HubStudent |
| Ib.LnkEnrollment | CourseSectionHk | binary(32) | NOT NULL | FK | To HubCourseSection |
| Ib.LnkEnrollment | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.LnkEnrollment | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.LnkAttendance | AttendanceHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.LnkAttendance | StudentHk | binary(32) | NOT NULL | FK | To HubStudent |
| Ib.LnkAttendance | CourseSectionHk | binary(32) | NOT NULL | FK | To HubCourseSection |
| Ib.LnkAttendance | AttendanceDate | date | NOT NULL | Dependent Child | Event date |
| Ib.LnkAttendance | PeriodNumber | tinyint | NOT NULL | Dependent Child | Period number |
| Ib.LnkAttendance | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.LnkAttendance | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.LnkAssessmentResult | AssessmentResultHk | binary(32) | NOT NULL | Hash Key / PK | Primary key |
| Ib.LnkAssessmentResult | StudentHk | binary(32) | NOT NULL | FK | To HubStudent |
| Ib.LnkAssessmentResult | AssessmentHk | binary(32) | NOT NULL | FK | To HubAssessment |
| Ib.LnkAssessmentResult | CourseSectionHk | binary(32) | NOT NULL | FK | To HubCourseSection |
| Ib.LnkAssessmentResult | LoadDts | datetime2(7) | NOT NULL | Audit | Load timestamp |
| Ib.LnkAssessmentResult | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatStudentPersonal | StudentHk | binary(32) | NOT NULL | Parent FK / PK Part | To HubStudent |
| Ib.SatStudentPersonal | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatStudentPersonal | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatStudentPersonal | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatStudentPersonal | FirstName | varchar(100) | NULL | Descriptive | PII |
| Ib.SatStudentPersonal | MiddleName | varchar(100) | NULL | Descriptive | PII |
| Ib.SatStudentPersonal | LastName | varchar(100) | NULL | Descriptive | PII |
| Ib.SatStudentPersonal | PreferredName | varchar(100) | NULL | Descriptive | PII |
| Ib.SatStudentPersonal | BirthDate | date | NULL | Descriptive | PII |
| Ib.SatStudentPersonal | Gender | char(1) | NULL | Descriptive | No declared reference |
| Ib.SatStudentPersonal | Nationality | varchar(2) | NULL | Descriptive | ISO comment only |
| Ib.SatStudentPersonal | NativeLanguage | varchar(50) | NULL | Descriptive | No declared reference |
| Ib.SatStudentPersonal | Email | varchar(255) | NULL | Descriptive | PII |
| Ib.SatStudentPersonal | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatStudentAcademic | StudentHk | binary(32) | NOT NULL | Parent FK / PK Part | To HubStudent |
| Ib.SatStudentAcademic | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatStudentAcademic | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatStudentAcademic | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatStudentAcademic | GradeLevel | varchar(10) | NULL | Descriptive | Free-text examples in comment |
| Ib.SatStudentAcademic | IbCandidateCode | varchar(20) | NULL | Descriptive | Candidate code |
| Ib.SatStudentAcademic | EnrollmentStatus | varchar(20) | NULL | Descriptive | No declared reference |
| Ib.SatStudentAcademic | AdmissionDate | date | NULL | Descriptive | Admission date |
| Ib.SatStudentAcademic | HouseOrHomeroom | varchar(30) | NULL | Descriptive | Homeroom |
| Ib.SatStudentAcademic | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatTeacherDetails | TeacherHk | binary(32) | NOT NULL | Parent FK / PK Part | To HubTeacher |
| Ib.SatTeacherDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatTeacherDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatTeacherDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatTeacherDetails | FirstName | varchar(100) | NULL | Descriptive | PII |
| Ib.SatTeacherDetails | LastName | varchar(100) | NULL | Descriptive | PII |
| Ib.SatTeacherDetails | Email | varchar(255) | NULL | Descriptive | PII |
| Ib.SatTeacherDetails | Department | varchar(100) | NULL | Descriptive | Free-text |
| Ib.SatTeacherDetails | IbWorkshopCertified | bit | NULL | Descriptive | Certification flag |
| Ib.SatTeacherDetails | IsActive | bit | NULL | Descriptive | Status flag |
| Ib.SatTeacherDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatCourseDetails | CourseHk | binary(32) | NOT NULL | Parent FK / PK Part | To HubCourse |
| Ib.SatCourseDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatCourseDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatCourseDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatCourseDetails | CourseName | varchar(200) | NULL | Descriptive | Name |
| Ib.SatCourseDetails | ProgrammeCode | varchar(10) | NULL | Descriptive | Matches Programme domain but no FK |
| Ib.SatCourseDetails | SubjectGroup | tinyint | NULL | Descriptive | Comment says DP groups 1-6 |
| Ib.SatCourseDetails | SubjectArea | varchar(100) | NULL | Descriptive | Area |
| Ib.SatCourseDetails | CourseLevel | varchar(10) | NULL | Descriptive | HL/SL/Standard comment |
| Ib.SatCourseDetails | LanguageOfInstruction | varchar(50) | NULL | Descriptive | Free-text |
| Ib.SatCourseDetails | TeachingHours | smallint | NULL | Descriptive | Comment says 240 HL / 150 SL |
| Ib.SatCourseDetails | IsCore | bit | NULL | Descriptive | Core indicator |
| Ib.SatCourseDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatCourseSectionDetails | CourseSectionHk | binary(32) | NOT NULL | Parent FK / PK Part | To HubCourseSection |
| Ib.SatCourseSectionDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatCourseSectionDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatCourseSectionDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatCourseSectionDetails | SectionCode | varchar(20) | NULL | Descriptive | Section identifier |
| Ib.SatCourseSectionDetails | Room | varchar(30) | NULL | Descriptive | Room |
| Ib.SatCourseSectionDetails | SchedulePeriod | varchar(30) | NULL | Descriptive | Free-text schedule |
| Ib.SatCourseSectionDetails | Capacity | smallint | NULL | Descriptive | Section capacity |
| Ib.SatCourseSectionDetails | SectionStatus | varchar(20) | NULL | Descriptive | No declared reference |
| Ib.SatCourseSectionDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatSchoolDetails | SchoolHk | binary(32) | NOT NULL | Parent FK / PK Part | To HubSchool |
| Ib.SatSchoolDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatSchoolDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatSchoolDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatSchoolDetails | SchoolName | varchar(200) | NULL | Descriptive | Name |
| Ib.SatSchoolDetails | CountryCode | varchar(2) | NULL | Descriptive | ISO-like code, no FK |
| Ib.SatSchoolDetails | City | varchar(100) | NULL | Descriptive | City |
| Ib.SatSchoolDetails | TimeZone | varchar(50) | NULL | Descriptive | Free-text |
| Ib.SatSchoolDetails | AuthorizedProgrammes | varchar(50) | NULL | Descriptive | Multi-valued delimited attribute |
| Ib.SatSchoolDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatAcademicTermDetails | AcademicTermHk | binary(32) | NOT NULL | Parent FK / PK Part | To HubAcademicTerm |
| Ib.SatAcademicTermDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatAcademicTermDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatAcademicTermDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatAcademicTermDetails | TermName | varchar(50) | NULL | Descriptive | Term name |
| Ib.SatAcademicTermDetails | AcademicYear | varchar(9) | NULL | Descriptive | e.g. 2025-2026 |
| Ib.SatAcademicTermDetails | StartDate | date | NULL | Descriptive | Start |
| Ib.SatAcademicTermDetails | EndDate | date | NULL | Descriptive | End |
| Ib.SatAcademicTermDetails | InstructionalDays | smallint | NULL | Descriptive | Number of days |
| Ib.SatAcademicTermDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatProgrammeDetails | ProgrammeHk | binary(32) | NOT NULL | Parent FK / PK Part | To HubProgramme |
| Ib.SatProgrammeDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatProgrammeDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatProgrammeDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatProgrammeDetails | ProgrammeName | varchar(100) | NULL | Descriptive | Name |
| Ib.SatProgrammeDetails | AgeRange | varchar(20) | NULL | Descriptive | Range as text |
| Ib.SatProgrammeDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatAssessmentDetails | AssessmentHk | binary(32) | NOT NULL | Parent FK / PK Part | To HubAssessment |
| Ib.SatAssessmentDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatAssessmentDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatAssessmentDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatAssessmentDetails | AssessmentName | varchar(200) | NULL | Descriptive | Name |
| Ib.SatAssessmentDetails | AssessmentType | varchar(20) | NULL | Descriptive | No declared reference |
| Ib.SatAssessmentDetails | IsInternal | bit | NULL | Descriptive | Internal flag |
| Ib.SatAssessmentDetails | MaxScore | decimal(8,2) | NULL | Descriptive | Maximum score |
| Ib.SatAssessmentDetails | WeightPercent | decimal(5,2) | NULL | Descriptive | Weight |
| Ib.SatAssessmentDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatEnrollmentDetails | EnrollmentHk | binary(32) | NOT NULL | Parent FK / PK Part | To LnkEnrollment |
| Ib.SatEnrollmentDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatEnrollmentDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatEnrollmentDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatEnrollmentDetails | EnrollmentStatus | varchar(20) | NULL | Descriptive | No declared reference |
| Ib.SatEnrollmentDetails | CourseLevel | varchar(10) | NULL | Descriptive | HL/SL |
| Ib.SatEnrollmentDetails | EnrollDate | date | NULL | Descriptive | Enrollment date |
| Ib.SatEnrollmentDetails | DropDate | date | NULL | Descriptive | Drop date |
| Ib.SatEnrollmentDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatStudentProgrammeDetails | StudentProgrammeHk | binary(32) | NOT NULL | Parent FK / PK Part | To LnkStudentProgramme |
| Ib.SatStudentProgrammeDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatStudentProgrammeDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatStudentProgrammeDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatStudentProgrammeDetails | CandidateType | varchar(30) | NULL | Descriptive | Diploma/Course candidate comment |
| Ib.SatStudentProgrammeDetails | StartDate | date | NULL | Descriptive | Start date |
| Ib.SatStudentProgrammeDetails | ExpectedGraduationDate | date | NULL | Descriptive | Graduation date |
| Ib.SatStudentProgrammeDetails | ProgrammeStatus | varchar(20) | NULL | Descriptive | No declared reference |
| Ib.SatStudentProgrammeDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatAttendanceDetails | AttendanceHk | binary(32) | NOT NULL | Parent FK / PK Part | To LnkAttendance |
| Ib.SatAttendanceDetails | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatAttendanceDetails | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatAttendanceDetails | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatAttendanceDetails | AttendanceStatusCode | varchar(10) | NULL | Descriptive | Comment refers to RefAttendanceStatus; no FK declared |
| Ib.SatAttendanceDetails | MinutesLate | smallint | NULL | Descriptive | Minutes late |
| Ib.SatAttendanceDetails | AbsenceReason | varchar(200) | NULL | Descriptive | Reason |
| Ib.SatAttendanceDetails | RecordedBy | varchar(100) | NULL | Descriptive | User/source actor |
| Ib.SatAttendanceDetails | RecordedDts | datetime2(7) | NULL | Descriptive | Recorded timestamp |
| Ib.SatAttendanceDetails | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.SatAssessmentResult | AssessmentResultHk | binary(32) | NOT NULL | Parent FK / PK Part | To LnkAssessmentResult |
| Ib.SatAssessmentResult | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Satellite load timestamp |
| Ib.SatAssessmentResult | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.SatAssessmentResult | HashDiff | binary(32) | NOT NULL | Change Detection | Hashdiff present |
| Ib.SatAssessmentResult | RawScore | decimal(8,2) | NULL | Descriptive | Score |
| Ib.SatAssessmentResult | IbGrade | tinyint | NULL | Descriptive | Comment says 1-7 |
| Ib.SatAssessmentResult | PredictedGrade | tinyint | NULL | Descriptive | Comment says 1-7 |
| Ib.SatAssessmentResult | ResultType | varchar(20) | NULL | Descriptive | Predicted/Internal/Moderated/Final |
| Ib.SatAssessmentResult | AssessedDate | date | NULL | Descriptive | Assessed date |
| Ib.SatAssessmentResult | AssessedBy | varchar(100) | NULL | Descriptive | Assessor |
| Ib.SatAssessmentResult | RecordSource | varchar(100) | NOT NULL | Audit | Source system |
| Ib.RefAttendanceStatus | AttendanceStatusCode | varchar(10) | NOT NULL | Reference PK | Code |
| Ib.RefAttendanceStatus | StatusName | varchar(50) | NOT NULL | Reference Attribute | Name |
| Ib.RefAttendanceStatus | IsPresent | bit | NOT NULL | Reference Attribute | Flag |
| Ib.RefAttendanceStatus | IsExcused | bit | NOT NULL | Reference Attribute | Flag |
| Ib.BvSatAttendanceSummary | EnrollmentHk | binary(32) | NOT NULL | Parent FK / PK Part | To LnkEnrollment |
| Ib.BvSatAttendanceSummary | LoadDts | datetime2(7) | NOT NULL | PK Part / Historization | Load timestamp |
| Ib.BvSatAttendanceSummary | LoadEndDts | datetime2(7) | NULL | Historization | End timestamp |
| Ib.BvSatAttendanceSummary | DaysPresent | int | NULL | Derived Metric | Summary |
| Ib.BvSatAttendanceSummary | DaysLate | int | NULL | Derived Metric | Summary |
| Ib.BvSatAttendanceSummary | DaysAbsentExcused | int | NULL | Derived Metric | Summary |
| Ib.BvSatAttendanceSummary | DaysAbsentUnexcused | int | NULL | Derived Metric | Summary |
| Ib.BvSatAttendanceSummary | AttendancePercent | decimal(5,2) | NULL | Derived Metric | Summary |
| Ib.BvSatAttendanceSummary | RecordSource | varchar(100) | NOT NULL | Audit | Source system |

# Relationship Inventory

| Relationship Type | From Object | From Column(s) | To Object | To Column(s) | Notes |
|---|---|---|---|---|---|
| FK | Ib.LnkSectionOffering | CourseSectionHk | Ib.HubCourseSection | CourseSectionHk | Declared |
| FK | Ib.LnkSectionOffering | CourseHk | Ib.HubCourse | CourseHk | Declared |
| FK | Ib.LnkSectionOffering | AcademicTermHk | Ib.HubAcademicTerm | AcademicTermHk | Declared |
| FK | Ib.LnkSectionOffering | SchoolHk | Ib.HubSchool | SchoolHk | Declared |
| FK | Ib.LnkSectionTeacher | CourseSectionHk | Ib.HubCourseSection | CourseSectionHk | Declared |
| FK | Ib.LnkSectionTeacher | TeacherHk | Ib.HubTeacher | TeacherHk | Declared |
| FK | Ib.LnkStudentProgramme | StudentHk | Ib.HubStudent | StudentHk | Declared |
| FK | Ib.LnkStudentProgramme | ProgrammeHk | Ib.HubProgramme | ProgrammeHk | Declared |
| FK | Ib.LnkStudentProgramme | SchoolHk | Ib.HubSchool | SchoolHk | Declared |
| FK | Ib.LnkEnrollment | StudentHk | Ib.HubStudent | StudentHk | Declared |
| FK | Ib.LnkEnrollment | CourseSectionHk | Ib.HubCourseSection | CourseSectionHk | Declared |
| FK | Ib.LnkAttendance | StudentHk | Ib.HubStudent | StudentHk | Declared |
| FK | Ib.LnkAttendance | CourseSectionHk | Ib.HubCourseSection | CourseSectionHk | Declared |
| FK | Ib.LnkAssessmentResult | StudentHk | Ib.HubStudent | StudentHk | Declared |
| FK | Ib.LnkAssessmentResult | AssessmentHk | Ib.HubAssessment | AssessmentHk | Declared |
| FK | Ib.LnkAssessmentResult | CourseSectionHk | Ib.HubCourseSection | CourseSectionHk | Declared |
| FK | Ib.SatStudentPersonal | StudentHk | Ib.HubStudent | StudentHk | Declared |
| FK | Ib.SatStudentAcademic | StudentHk | Ib.HubStudent | StudentHk | Declared |
| FK | Ib.SatTeacherDetails | TeacherHk | Ib.HubTeacher | TeacherHk | Declared |
| FK | Ib.SatCourseDetails | CourseHk | Ib.HubCourse | CourseHk | Declared |
| FK | Ib.SatCourseSectionDetails | CourseSectionHk | Ib.HubCourseSection | CourseSectionHk | Declared |
| FK | Ib.SatSchoolDetails | SchoolHk | Ib.HubSchool | SchoolHk | Declared |
| FK | Ib.SatAcademicTermDetails | AcademicTermHk | Ib.HubAcademicTerm | AcademicTermHk | Declared |
| FK | Ib.SatProgrammeDetails | ProgrammeHk | Ib.HubProgramme | ProgrammeHk | Declared |
| FK | Ib.SatAssessmentDetails | AssessmentHk | Ib.HubAssessment | AssessmentHk | Declared |
| FK | Ib.SatEnrollmentDetails | EnrollmentHk | Ib.LnkEnrollment | EnrollmentHk | Declared |
| FK | Ib.SatStudentProgrammeDetails | StudentProgrammeHk | Ib.LnkStudentProgramme | StudentProgrammeHk | Declared |
| FK | Ib.SatAttendanceDetails | AttendanceHk | Ib.LnkAttendance | AttendanceHk | Declared |
| FK | Ib.SatAssessmentResult | AssessmentResultHk | Ib.LnkAssessmentResult | AssessmentResultHk | Declared |
| FK | Ib.BvSatAttendanceSummary | EnrollmentHk | Ib.LnkEnrollment | EnrollmentHk | Declared |
| Undeclared logical reference | Ib.SatAttendanceDetails | AttendanceStatusCode | Ib.RefAttendanceStatus | AttendanceStatusCode | Mentioned by column comment and profiling workbook, but no FK in DDL |
| Undeclared logical reference | Ib.SatCourseDetails | ProgrammeCode | Ib.HubProgramme / SatProgrammeDetails | ProgrammeBk / descriptive attrs | Logical domain overlap only |

# Documentation Gaps

| Gap ID | Object | Gap Type | Description | Canonical Impact | Suggested Documentation Improvement |
|---|---|---|---|---|---|
| DG-001 | Global hash standard | Missing derivation details | Header states SHA2_256 of UPPER/TRIM BK(s) joined by `||`, but does not specify null handling, datatype casting, collation, Unicode handling, or binary-to-hex comparison standard. | Cross-platform canonical key reproducibility risk | Publish enterprise hash specification with exact normalization rules and examples. |
| DG-002 | Link hash keys | Missing hash composition | Link HK derivation rules are not documented per link, especially where dependent child keys exist. | Ambiguous canonical relationship key derivation | Document exact ordered hash inputs for each link. |
| DG-003 | Satellite hashdiffs | Missing hashdiff scope | DDL includes HashDiff columns but does not specify included attributes, ordering, null treatment, or delimiters. | Attribute change tracking may not map consistently to canonical SCD logic | Provide hashdiff attribute manifests per satellite. |
| DG-004 | Business keys | Partial business key semantics | Comments provide examples but not source-system survivorship or conformance rules. | Canonical entity matching may be inconsistent across systems | Define BK governance and source precedence rules. |
| DG-005 | Reference domains | Incomplete controlled vocabularies | Several coded text columns have comments but no declared reference objects or rule sets. | Canonical enumerations may require rework and mapping exceptions | Add reference/domain catalog for all coded attributes. |
| DG-006 | Business Vault summary | Missing derivation logic | `BvSatAttendanceSummary` exists without formula or refresh rule documentation. | Canonical KPI semantics may diverge from source vault metrics | Document aggregation grain, formulas, late-arriving handling, and restatement policy. |
| DG-007 | Profiling evidence | No executed data results accessible | Workbook text indicates data-dependent checks remain NOT_RUN. | Canonical mapping decisions lack data-backed validation | Execute profiling and capture counts, defects, and exceptions. |

# Data Profiling Summary

| Profiling Area | Status | Evidence Source | Result | Notes |
|---|---|---|---|---|
| Workbook accessibility | EXECUTED | Accessible extracted text from workbook | Limited | Only high-level workbook text was readable; no detailed sheet tables/results were accessible via the file-read tool. |
| DDL inventory count check | DDL_REVIEWED | Workbook text + DDL | Consistent | Workbook states 8 hubs, 6 links, 13 standard satellites, 1 reference table, 1 BV satellite; DDL confirms this. |
| Foreign key inventory count | DDL_REVIEWED | Workbook text + DDL | Consistent | Workbook expects 30 FKs; DDL contains 30 declared FKs. |
| Explicit index count | DDL_REVIEWED | Workbook text + DDL | Consistent | Workbook expects 21 explicit indexes excluding PK indexes; DDL confirms 21. |
| Attendance status referential design | DDL_REVIEWED / PROFILING-CONFIRMED | Workbook text + DDL | Finding confirmed | Workbook explicitly flags missing FK from `SatAttendanceDetails.AttendanceStatusCode` to `RefAttendanceStatus`; DDL confirms absence. |
| Null analysis | NOT_RUN | Workbook text | Not executed | No source data available. |
| Duplicate analysis | NOT_RUN | Workbook text | Not executed | No source data available. |
| Invalid code analysis | NOT_RUN | Workbook text | Not executed | No source data available beyond 4 seed rows in reference table. |
| Referential integrity data check | NOT_RUN | Workbook text | Not executed | Structural RI reviewed only; data-level RI not tested. |
| Unexpected values analysis | NOT_RUN | Workbook text | Not executed | No source data available. |
| Distribution analysis | NOT_RUN | Workbook text | Not executed | No source data available. |
| Temporal inconsistency analysis | NOT_RUN | Workbook text | Not executed | No source data available. |

| Issue ID | Issue Title | Category | Severity | Affected Object | Description | Impact on Canonical Model | Recommended Action |
|---|---|---|---|---|---|---|---|
| DVR-001 | Attendance status code lacks declared reference integrity | DDL-confirmed; Profiling-confirmed | High | Ib.SatAttendanceDetails.AttendanceStatusCode; Ib.RefAttendanceStatus | The profiling workbook explicitly states that `SatAttendanceDetails.AttendanceStatusCode` has no declared foreign key to `RefAttendanceStatus`, and the DDL confirms that only the parent-link FK is declared for `SatAttendanceDetails`. This leaves the attendance status domain unenforced structurally. | Canonical attendance status mapping may produce orphan or nonstandard status codes, increasing ambiguity in canonical code sets and exception handling. | Add a foreign key or an enforced domain-validation rule from `SatAttendanceDetails.AttendanceStatusCode` to `RefAttendanceStatus.AttendanceStatusCode`; if soft enforcement is preferred, document and implement ETL validation with reject/report logic. |
| DVR-002 | Course carries programme as free text instead of governed relationship | DDL-confirmed; Inferred risk | High | Ib.SatCourseDetails.ProgrammeCode; Ib.HubProgramme | `SatCourseDetails` stores `ProgrammeCode` as a descriptive varchar even though a dedicated `HubProgramme` exists. No FK or link structurally associates course to programme. | Canonical course-to-programme relationships may need inference from text values instead of governed keys, risking duplicate programme concepts and inconsistent mappings. | Model an explicit course-programme relationship, preferably via a link or a governed reference to `HubProgramme`/`ProgrammeBk`, and migrate `ProgrammeCode` to validated relationship logic. |
| DVR-003 | Authorized programmes stored as delimited multi-value attribute | DDL-confirmed; Inferred risk | High | Ib.SatSchoolDetails.AuthorizedProgrammes | `AuthorizedProgrammes` is a comma-delimited text attribute in a satellite rather than a normalized relationship between school and programme. | Canonical school-programme authorization relationships cannot be mapped reliably without parsing multi-valued text, reducing lineage and relationship clarity. | Replace the delimited attribute with a proper link such as School-Programme authorization plus optional satellite for effective dates/status. |
| DVR-004 | Section hub business key is opaque concatenated text | DDL-confirmed; Inferred risk | Medium | Ib.HubCourseSection.CourseSectionBk | The comment indicates `SchoolCode||TermCode||CourseCode||SectionCode`, but the stored BK is a single varchar field with no atomic components in the hub. | Canonical section entity construction may require reverse parsing or external knowledge to identify school, term, course, and section components, especially for source-system harmonization. | Document exact BK composition and delimiter escaping rules; consider exposing parsed atomic components in a supporting satellite or staging metadata for canonical mapping. |
| DVR-005 | No alternate-key uniqueness constraints on link natural combinations | DDL-confirmed; Inferred risk | High | All link tables | Links use HK primary keys and foreign keys, but there are no declared unique constraints on the natural relationship-driving columns such as `(StudentHk, CourseSectionHk)` for enrollment or `(StudentHk, CourseSectionHk, AttendanceDate, PeriodNumber)` for attendance. Missing uniqueness does not prove duplicates exist, but it leaves duplicate relationship instances structurally possible. | Canonical relationship extraction may face duplicate edge generation and uncertain deduplication rules. | Add unique constraints or at minimum ETL duplicate checks on each link’s natural driving key set and document late-arriving/restatement rules. |
| DVR-006 | Teacher role embedded in link without governed domain | DDL-confirmed; Inferred risk | Medium | Ib.LnkSectionTeacher.TeacherRole | `TeacherRole` is a dependent child in the link, but no reference table or domain enforcement exists for values such as PRIMARY, CO-TEACHER, SUBSTITUTE. | Canonical role mapping may require manual standardization and may fragment section-teacher relationship semantics. | Create a reference/domain table for teacher roles or document an approved controlled vocabulary with validation rules. |
| DVR-007 | Attendance event dependent child keys lack documented hash-key composition | Documentation gap; Inferred risk | High | Ib.LnkAttendance | The DDL comment states attendance is student + section + date + period, but exact HK derivation ordering and handling for dependent child keys are not documented beyond a generic header. | Canonical event-key reproduction across platforms may be inconsistent, especially if dependent child values are normalized differently. | Publish precise HK derivation specifications for `LnkAttendance`, including attribute order, formatting, null treatment, datatype conversion, and timezone/date handling. |
| DVR-008 | Assessment result link lacks documented result grain semantics | DDL-confirmed; Inferred risk | High | Ib.LnkAssessmentResult; Ib.SatAssessmentResult | The model links student, assessment, and section, while descriptive result satellite includes `ResultType`, `AssessedDate`, and grades. There is no declared uniqueness or documentation showing whether multiple result attempts, revisions, moderated/final results, or retakes are expected as separate link records or satellite versions. | Canonical assessment-result entity design may be ambiguous, affecting cardinality, result versioning, and survivorship rules. | Define the business grain for assessment results, add uniqueness rules, and specify whether result variations are represented by separate link keys or satellite historization only. |
| DVR-009 | Several coded domains are stored as unconstrained text | DDL-confirmed; Inferred risk | Medium | Multiple satellites | Columns such as `EnrollmentStatus`, `ProgrammeStatus`, `SectionStatus`, `AssessmentType`, `ResultType`, `CourseLevel`, `Gender`, and `CountryCode` rely on comments rather than structural reference enforcement. | Canonical code-set harmonization will require additional cleansing and may create mapping many-to-one collapses or unresolved values. | Define reference tables or enterprise domain standards for all reusable coded attributes and enforce them in ingestion or via RI where appropriate. |
| DVR-010 | Hashdiff implementation details are undocumented | Documentation gap | Medium | All satellites with HashDiff | Every satellite contains `HashDiff`, but the DDL does not define which columns participate, ordering, normalization, null treatment, or whether audit columns are excluded. | Canonical change-detection alignment and reconciliation with vault history may be unreliable across consuming pipelines. | Publish satellite-by-satellite hashdiff specifications and include regression tests to ensure deterministic calculation. |
| DVR-011 | Historization end-date governance is not defined | Documentation gap; Inferred risk | Medium | All standard satellites and BvSatAttendanceSummary | Satellites contain `LoadEndDts`, but the DDL does not specify whether it is maintained as end-dating, whether open records use NULL, how overlaps are prevented, or how point-in-time reconstruction should be performed. | Canonical temporal mapping may misinterpret current vs historical records and create conflicting attribute versions. | Document historization rules, add ETL controls to prevent overlapping active periods, and publish current-record logic. |
| DVR-012 | Business Vault attendance summary has undocumented derivation logic | DDL-confirmed; Documentation gap | High | Ib.BvSatAttendanceSummary | The BV table exists as a computed attendance summary per enrollment, but no formulas, source dependencies, refresh frequency, or treatment of late-arriving attendance are documented. | Canonical metrics and derived attributes could diverge from Business Vault outputs, undermining trust in KPI mappings. | Document full derivation rules, aggregation windows, exception handling, and restatement policy; consider metadata-driven lineage back to attendance detail. |
| DVR-013 | No PIT or bridge structures are present for historized consumption | DDL-confirmed; Inferred risk | Low | Entire model | The DDL contains hubs, links, satellites, a reference table, and one BV satellite, but no point-in-time or bridge tables. This is not a defect, but it may limit efficient assembly of current/historical canonical views. | Canonical model construction may require more complex temporal joins and custom logic outside the vault. | If canonical consumption requires temporal snapshots or many-hop relationship acceleration, add PIT/bridge structures or publish standardized consumption views. |
| DVR-014 | Reference coverage limited to attendance status only | DDL-confirmed; Inferred risk | Medium | Reference/domain layer | Only one explicit reference table is modeled despite several repeated business domains embedded as text. | Canonical domain standardization effort will shift downstream into mapping logic rather than being governed in the vault. | Expand the reference layer for shared domains such as programme status, enrollment status, course level, assessment type, gender, country, and teacher role. |
| DVR-015 | Hash standard is too generic for implementation certainty | Documentation gap | Medium | Global design standard | The DDL header says hashes are SHA2_256 of `UPPER/TRIM` business keys joined by `||`, but does not define null tokenization, whitespace normalization beyond trim, collation, character encoding, or delimiter escaping. | Canonical key regeneration in non-SQL Server tooling may produce mismatched keys and broken lineage. | Publish an enterprise canonical hash specification with exact transformation steps and test vectors for hubs, links, and hashdiffs. |
| DVR-016 | Link between section offering and teacher assignment is indirect only | DDL-confirmed; Inferred risk | Medium | Ib.LnkSectionOffering; Ib.LnkSectionTeacher | `LnkSectionTeacher` links teacher directly to `CourseSectionHk`, while `LnkSectionOffering` separately links the same section to course, term, and school. If `CourseSectionBk` is globally unique this may be adequate, but the model relies on that assumption without explicit documentation. | Canonical section-offering relationship assembly may require inferred joins and assumptions about section uniqueness across school and term contexts. | Document whether `CourseSectionBk` is globally unique across all schools/terms by construction; if not, align teacher assignment to the full offering grain. |
| DVR-017 | Candidate code semantics are unclear | DDL-confirmed; Documentation gap | Medium | Ib.SatStudentAcademic.IbCandidateCode | The attribute is commented as IB candidate personal code, but format, uniqueness scope, and lifecycle are not documented or enforced. | Canonical student identity matching may incorrectly elevate or ignore this potentially important external identifier. | Document the identifier’s business meaning, uniqueness scope, masking rules, and whether it should be treated as an alternate key in canonical identity mapping. |
| DVR-018 | Profiling workbook provides no executed data-quality results | Profiling-confirmed; Validation gap | Critical | IB_DataVault_Data_Profiling_Plan.xlsx / entire model | The accessible workbook content explicitly states data-dependent checks remain `NOT_RUN` and that no representative student, enrollment, attendance, or assessment dataset was supplied. Therefore nulls, duplicates, invalid codes, unexpected distributions, referential breaks, and temporal inconsistencies cannot be asserted from evidence. | Canonical model decisions cannot be fully validated against actual source/vault data behavior, leaving key, attribute, and relationship mappings insufficiently evidenced. | Execute the profiling plan against a populated SQL Server database or approved extracts and update this review with measured counts, defect rates, and confirmed exceptions before final canonical sign-off. |
| DVR-019 | Data-level null, duplicate, and value-distribution checks are unvalidated | Validation gap | High | Entire model | Required profiling checks for nulls, duplicates, invalid codes, unexpected values, distributions, and temporal consistency could not be completed because only DDL and workbook instructions were available. | Canonical attribute optionality, survivorship, and relationship cardinality assumptions remain provisional. | Run the planned profiling checks and record actual outcomes by object and column, distinguishing pass/fail and remediation needs. |
| DVR-020 | No explicit uniqueness on hub hash keys vs business-key hash reproducibility test evidence | Validation gap | Medium | All hubs | Hubs have PKs on HK and unique indexes on BK, which is structurally sound. However, without test data or hashing validation evidence, consistency between BK normalization and HK generation cannot be confirmed. | Canonical entity matching that relies on reproducing vault HKs may face reconciliation issues during integration testing. | Perform hash regeneration validation using sampled business keys from populated data and reconcile generated HKs to stored HKs. |
| DVR-021 | Seed data exists only for attendance reference domain | DDL-confirmed; Validation gap | Low | Ib.RefAttendanceStatus | The DDL inserts four attendance status rows, but no other operational data is present in accessible inputs. | Canonical domain validation can only be partially tested; end-to-end entity/relationship mapping remains unverified. | Load representative test data or provide extracts covering all modeled domains to support canonical validation. |
