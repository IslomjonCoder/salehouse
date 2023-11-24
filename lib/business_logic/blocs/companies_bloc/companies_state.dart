part of 'companies_bloc.dart';

 class CompaniesState {
   Status status;
   List<CompanyModel> companies;
   String error;

   CompaniesState({
     this.status = Status.initial,
     this.companies = const [],
     this.error = '',
   });

   CompaniesState copyWith({
    Status? status,
    List<CompanyModel>? companies,
    String? error,
  }) {
    return CompaniesState(
      status: status ?? this.status,
      companies: companies ?? this.companies,
      error: error ?? this.error,
    );
  }
}

