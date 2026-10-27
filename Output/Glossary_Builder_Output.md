
# Glossary Builder Output

## Executive Overview

This document provides a comprehensive data glossary and dictionary for the IB (International Baccalaureate) Data Vault. It includes detailed information on all tables, columns, relationships, and data profiling results, generated from the `IB_datavault2.sql` DDL file and the `IB_DataVault_Data_Profiling_Plan.xlsx` data profiling plan.

## Table Inventory

| Schema | Table Name                  | Table Type       | Business Description                                               |
|--------|-----------------------------|------------------|--------------------------------------------------------------------|
| Ib     | HubStudent                  | Hub              | Represents a unique student.                                       |
| Ib     | HubTeacher                  | Hub              | Represents a unique teacher.                                       |
| Ib     | HubCourse                   | Hub              | Represents a unique course.                                        |
| Ib     | HubCourseSection            | Hub              | Represents a unique section of a course.                           |
| Ib     | HubSchool                   | Hub              | Represents a unique school.                                        |
| Ib     | HubAcademicTerm             | Hub              | Represents a unique academic term.                                 |
| Ib     | HubProgramme                | Hub              | Represents a unique IB programme.                                  |
| Ib     | HubAssessment               | Hub              | Represents a unique assessment.                                    |
| Ib     | LnkSectionOffering          | Link             | Associates a course section with a course, academic term, and school. |
| Ib     | LnkSectionTeacher           | Link             | Assigns a teacher to a course section with a specific role.        |
| Ib     | LnkStudentProgramme         | Link             | Associates a student with an IB programme at a school.             |
| Ib     | LnkEnrollment               | Link             | Enrolls a student in a course section.                             |
| Ib     | LnkAttendance               | Link             | Records a student's attendance for a course section on a given date. |
| Ib     | LnkAssessmentResult         | Link             | Stores the result of an assessment for a student in a course section.|
| Ib     | SatStudentPersonal          | Satellite        | Stores personal (PII) attributes of a student.                     |
| Ib     | SatStudentAcademic          | Satellite        | Stores academic attributes of a student.                           |
| Ib     | SatTeacherDetails           | Satellite        | Stores details about a teacher.                                    |
| Ib     | SatCourseDetails            | Satellite        | Stores details about a course.                                     |
| Ib     | SatCourseSectionDetails     | Satellite        | Stores details about a course section.                             |
| Ib     | SatSchoolDetails            | Satellite        | Stores details about a school.                                     |
| Ib     | SatAcademicTermDetails      | Satellite        | Stores details about an academic term.                             |
| Ib     | SatProgrammeDetails         | Satellite        | Stores details about an IB programme.                              |
| Ib     | SatAssessmentDetails        | Satellite        | Stores details about an assessment.                                |
| Ib     | SatEnrollmentDetails        | Satellite        | Stores details about a student's enrollment in a course section.   |
| Ib     | SatStudentProgrammeDetails  | Satellite        | Stores details about a student's IB programme.                     |
| Ib     | SatAttendanceDetails        | Satellite        | Stores details about a student's attendance.                       |
| Ib     | SatAssessmentResult         | Satellite        | Stores details about a student's assessment result.                |
| Ib     | RefAttendanceStatus         | Reference        | A reference table for attendance status codes.                     |
| Ib     | BvSatAttendanceSummary      | Business Vault   | A computed satellite for attendance summary per enrollment.        |

## Column Data Dictionary

| Schema | Table Name             | Table Type | Column Name      | Column Description                             | Data Type    | Key Column Flag | Referenced Table Name |
|--------|------------------------|------------|------------------|------------------------------------------------|--------------|-----------------|-----------------------|
| Ib     | HubStudent             | Hub        | StudentHk        | Hash key for the student                       | binary(32)   | PK              |                       |
| Ib     | HubStudent             | Hub        | StudentBk        | Business key for the student (school student ID) | varchar(50)  | BK, UQ          |                       |
| Ib     | HubStudent             | Hub        | LoadDts          | Load timestamp                                 | datetime2(7) | Metadata        |                       |
| Ib     | HubStudent             | Hub        | RecordSource     | Source of the record                             | varchar(100) | Metadata        |                       |
| Ib     | HubTeacher             | Hub        | TeacherHk        | Hash key for the teacher                       | binary(32)   | PK              |                       |
| Ib     | HubTeacher             | Hub        | TeacherBk        | Business key for the teacher (staff ID)        | varchar(50)  | BK, UQ          |                       |
| Ib     | HubTeacher             | Hub        | LoadDts          | Load timestamp                                 | datetime2(7) | Metadata        |                       |
| Ib     | HubTeacher             | Hub        | RecordSource     | Source of the record                             | varchar(100) | Metadata        |                       |
| Ib     | HubCourse              | Hub        | CourseHk         | Hash key for the course                        | binary(32)   | PK              |                       |
| Ib     | HubCourse              | Hub        | CourseBk         | Business key for the course (e.g. MATH-AA-HL)  | varchar(50)  | BK, UQ          |                       |
| Ib     | HubCourse              | Hub        | LoadDts          | Load timestamp                                 | datetime2(7) | Metadata        |                       |
| Ib     | HubCourse              | Hub        | RecordSource     | Source of the record                             | varchar(100) | Metadata        |                       |
| Ib     | HubCourseSection       | Hub        | CourseSectionHk  | Hash key for the course section                | binary(32)   | PK              |                       |
| Ib     | HubCourseSection       | Hub        | CourseSectionBk  | Business key for the course section            | varchar(120) | BK, UQ          |                       |
| Ib     | HubCourseSection       | Hub        | LoadDts          | Load timestamp                                 | datetime2(7) | Metadata        |                       |
| Ib     | HubCourseSection       | Hub        | RecordSource     | Source of the record                             | varchar(100) | Metadata        |                       |
| Ib     | HubSchool              | Hub        | SchoolHk         | Hash key for the school                        | binary(32)   | PK              |                       |
| Ib     | HubSchool              | Hub        | SchoolBk         | Business key for the school (IB school code)   | varchar(20)  | BK, UQ          |                       |
| Ib     | HubSchool              | Hub        | LoadDts          | Load timestamp                                 | datetime2(7) | Metadata        |                       |
| Ib     | HubSchool              | Hub        | RecordSource     | Source of the record                             | varchar(100) | Metadata        |                       |
| Ib     | HubAcademicTerm        | Hub        | AcademicTermHk   | Hash key for the academic term                 | binary(32)   | PK              |                       |
| Ib     | HubAcademicTerm        | Hub        | AcademicTermBk   | Business key for the academic term             | varchar(30)  | BK, UQ          |                       |
| Ib     | HubAcademicTerm        | Hub        | LoadDts          | Load timestamp                                 | datetime2(7) | Metadata        |                       |
| Ib     | HubAcademicTerm        | Hub        | RecordSource     | Source of the record                             | varchar(100) | Metadata        |                       |
| Ib     | HubProgramme           | Hub        | ProgrammeHk      | Hash key for the programme                     | binary(32)   | PK              |                       |
| Ib     | HubProgramme           | Hub        | ProgrammeBk      | Business key for the programme (PYP, MYP, DP, CP) | varchar(10)  | BK, UQ          |                       |
| Ib     | HubProgramme           | Hub        | LoadDts          | Load timestamp                                 | datetime2(7) | Metadata        |                       |
| Ib     | HubProgramme           | Hub        | RecordSource     | Source of the record                             | varchar(100) | Metadata        |                       |
| Ib     | HubAssessment          | Hub        | AssessmentHk     | Hash key for the assessment                    | binary(32)   | PK              |                       |
| Ib     | HubAssessment          | Hub        | AssessmentBk     | Business key for the assessment                | varchar(60)  | BK, UQ          |                       |
| Ib     | HubAssessment          | Hub        | LoadDts          | Load timestamp                                 | datetime2(7) | Metadata        |                       |
| Ib     | HubAssessment          | Hub        | RecordSource     | Source of the record                             | varchar(100) | Metadata        |                       |

## Relationship Inventory

| Table Name             | Column Name       | Relationship Type | Referenced Table Name | Referenced Column Name |
|------------------------|-------------------|-------------------|-----------------------|------------------------|
| LnkSectionOffering     | CourseSectionHk   | FOREIGN KEY       | HubCourseSection      | CourseSectionHk        |
| LnkSectionOffering     | CourseHk          | FOREIGN KEY       | HubCourse             | CourseHk               |
| LnkSectionOffering     | AcademicTermHk    | FOREIGN KEY       | HubAcademicTerm       | AcademicTermHk         |
| LnkSectionOffering     | SchoolHk          | FOREIGN KEY       | HubSchool             | SchoolHk               |
| LnkSectionTeacher      | CourseSectionHk   | FOREIGN KEY       | HubCourseSection      | CourseSectionHk        |
| LnkSectionTeacher      | TeacherHk         | FOREIGN KEY       | HubTeacher            | TeacherHk              |
| LnkStudentProgramme    | StudentHk         | FOREIGN KEY       | HubStudent            | StudentHk              |
| LnkStudentProgramme    | ProgrammeHk       | FOREIGN KEY       | HubProgramme          | ProgrammeHk            |
| LnkStudentProgramme    | SchoolHk          | FOREIGN KEY       | HubSchool             | SchoolHk               |
| LnkEnrollment          | StudentHk         | FOREIGN KEY       | HubStudent            | StudentHk              |
| LnkEnrollment          | CourseSectionHk   | FOREIGN KEY       | HubCourseSection      | CourseSectionHk        |
| LnkAttendance          | StudentHk         | FOREIGN KEY       | HubStudent            | StudentHk              |
| LnkAttendance          | CourseSectionHk   | FOREIGN KEY       | HubCourseSection      | CourseSectionHk        |
| LnkAssessmentResult    | StudentHk         | FOREIGN KEY       | HubStudent            | StudentHk              |
| LnkAssessmentResult    | AssessmentHk      | FOREIGN KEY       | HubAssessment         | AssessmentHk           |
| LnkAssessmentResult    | CourseSectionHk   | FOREIGN KEY       | HubCourseSection      | CourseSectionHk        |
| SatStudentPersonal     | StudentHk         | FOREIGN KEY       | HubStudent            | StudentHk              |
| SatStudentAcademic     | StudentHk         | FOREIGN KEY       | HubStudent            | StudentHk              |
| SatTeacherDetails      | TeacherHk         | FOREIGN KEY       | HubTeacher            | TeacherHk              |
| SatCourseDetails       | CourseHk          | FOREIGN KEY       | HubCourse             | CourseHk               |
| SatCourseSectionDetails| CourseSectionHk   | FOREIGN KEY       | HubCourseSection      | CourseSectionHk        |
| SatSchoolDetails       | SchoolHk          | FOREIGN KEY       | HubSchool             | SchoolHk               |
| SatAcademicTermDetails | AcademicTermHk    | FOREIGN KEY       | HubAcademicTerm       | AcademicTermHk         |
| SatProgrammeDetails    | ProgrammeHk       | FOREIGN KEY       | HubProgramme          | ProgrammeHk            |
| SatAssessmentDetails   | AssessmentHk      | FOREIGN KEY       | HubAssessment         | AssessmentHk           |
| SatEnrollmentDetails   | EnrollmentHk      | FOREIGN KEY       | LnkEnrollment         | EnrollmentHk           |
| SatStudentProgrammeDetails| StudentProgrammeHk| FOREIGN KEY       | LnkStudentProgramme   | StudentProgrammeHk     |
| SatAttendanceDetails   | AttendanceHk      | FOREIGN KEY       | LnkAttendance         | AttendanceHk           |
| SatAssessmentResult    | AssessmentResultHk| FOREIGN KEY       | LnkAssessmentResult   | AssessmentResultHk     |
| BvSatAttendanceSummary | EnrollmentHk      | FOREIGN KEY       | LnkEnrollment         | EnrollmentHk           |

## Documentation Gaps

| Table Name                  | Column Name         | Gap Type                       | Description                                | Recommended Clarification                                    |
|-----------------------------|---------------------|--------------------------------|--------------------------------------------|--------------------------------------------------------------|
| SatStudentPersonal          | Gender              | Unclear Terminology            | `char(1)` data type is not descriptive.    | Use a more descriptive data type or add a check constraint.  |
| SatStudentPersonal          | Nationality         | Unclear Terminology            | `varchar(2)` data type.                    | Specify the standard used (e.g., ISO 3166-1 alpha-2).        |
| SatStudentAcademic          | GradeLevel          | Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |
| SatTeacherDetails           | IbWorkshopCertified | Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |
| SatCourseDetails            | SubjectGroup        | Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |
| SatCourseSectionDetails     | SectionStatus       | Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |
| SatSchoolDetails            | AuthorizedProgrammes| Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |
| SatEnrollmentDetails        | EnrollmentStatus    | Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |
| SatStudentProgrammeDetails  | CandidateType       | Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |
| SatStudentProgrammeDetails  | ProgrammeStatus     | Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |
| SatAttendanceDetails        | AttendanceStatusCode| Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |
| SatAssessmentResult         | ResultType          | Missing Business Definition    | No business definition provided.           | Provide a clear business definition for this column.         |

## Data Profiling Summary

The following is a summary of the data profiling checks from the `IB_DataVault_Data_Profiling_Plan.xlsx` file.

| Table Name   | Column Name | Profiling Check | Result      | Count | Percentage | Status  |
|--------------|-------------|-----------------|-------------|-------|------------|---------|
| HubStudent   | StudentBk   | Uniqueness      | Not executed|       |            | Planned |
| HubStudent   | StudentBk   | Not Null        | Not executed|       |            | Planned |
| HubTeacher   | TeacherBk   | Uniqueness      | Not executed|       |            | Planned |
| HubTeacher   | TeacherBk   | Not Null        | Not executed|       |            | Planned |
| HubCourse    | CourseBk    | Uniqueness      | Not executed|       |            | Planned |
| HubCourse    | CourseBk    | Not Null        | Not executed|       |            | Planned |
| HubSchool    | SchoolBk    | Uniqueness      | Not executed|       |            | Planned |
| HubSchool    | SchoolBk    | Not Null        | Not executed|       |            | Planned |

