/*
ERROR / VALIDATION REPORT

Required inputs found:
- agent4.txt: AVAILABLE
- Microsoft Fabric Model Standards.txt: AVAILABLE

Generation halted because reliable Microsoft Fabric DDL cannot be completed without unresolved required information from the standards and mapping.

Blocking unresolved items:
1. Fabric target not confirmed.
   - Standards explicitly state the specific target (Fabric Warehouse or Lakehouse SQL analytics endpoint) must be confirmed before generating DDL.
   - DDL syntax and supported constraints may differ by target.

2. Schema convention not supplied.
   - Standards require consistent schema naming conventions.
   - No target schema name was provided, so schema-qualified executable DDL would require invention.

3. Key definitions are not fully specified.
   - Standards allow primary keys only when identified by the mapping or approved model specification.
   - Agent 4 provides canonical tables and columns but does not explicitly designate primary keys for every table.
   - Foreign keys/relationships are described contextually in remarks, but not as an approved enforceable constraint specification.

4. Nullability is not specified.
   - Standards state to apply NULL or NOT NULL only when supported by the source mapping or approved business rules.
   - The mapping does not provide nullability.

5. One canonical table is unresolved in the source mapping.
   - Attendance Summary has no usable canonical attribute list.
   - Agent 4 explicitly marks the table/attributes as Unresolved.
   - Standards require every canonical table and every canonical column to be included, which is not possible for this entity from supplied inputs.

6. Multiple relationship and reference details are ambiguous.
   - Course.ProgrammeCode has structural ambiguity per DV-005.
   - Attendance Event.AttendanceStatusCode notes missing FK to reference status per DV-002.
   - Several relationship-grain entities rely on link context, but enforceable relational key definitions are not explicitly supplied.

Because of the above, producing executable, standards-compliant Fabric DDL would require assumptions prohibited by the standards.

Canonical tables identified from agent4.txt:
- Student
- Student Programme Enrollment
- Programme
- Course
- Course Section
- School
- Academic Term
- Section Offering
- Teacher
- Section Teacher Assignment
- Course Enrollment
- Attendance Event
- Attendance Status
- Attendance Summary
- Assessment
- Assessment Result

Recommended next inputs required to complete DDL generation:
- Confirm Fabric target: Warehouse or Lakehouse SQL analytics endpoint.
- Confirm schema name(s).
- Provide approved key definitions (PK/FK) for each canonical table.
- Provide nullability rules.
- Provide the canonical attribute list for Attendance Summary.
- Confirm whether unresolved relationships should be documented only or implemented as constraints.

Status:
- DDL generation: NOT COMPLETED
- Output file created as validation report: YES
- GitHub publication: SUCCESS (subject to repository tool confirmation)
*/