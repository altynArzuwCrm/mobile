import 'package:crm/core/constants/strings/app_strings.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/projects/data/datasources/remote/project_remote_datasource.dart';
import 'package:crm/features/projects/domain/entities/project_entity.dart';
import 'package:crm/features/projects/domain/repositories/project_repository.dart';
import 'package:crm/features/projects/domain/usecases/create_project_usecase.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';
import 'package:dartz/dartz.dart';

class ProjectRepositoryImpl implements ProjectRepository{
  final NetworkInfo networkInfo;
final ProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl(this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, ProjectEntity>> createProject(CreateProjectParams params)async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.createProject(params);
        return Right(response.toEntity());
      } catch (error) {
        return  Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProject(int id) async{
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.deleteProject(id);
        return Right(response);
      } catch (error) {
        return  Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> editProject(CreateProjectParams params)async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.editProject(params);
        return Right(response.toEntity());
      } catch (error) {
        return  Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> getAllProjects(ProjectParams params)async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getAllProjects(params);
        final result = response.map((e)=>e.toEntity()).toList();
        return Right(result);
      } catch (error) {
        return  Left(ServerFailure('[Server]: $error'));
      }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> getProjectById(int id)async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // try {
        final response = await remoteDataSource.getProjectById(id);
        return Right(response.toEntity());
      // } catch (error) {
      //   return  Left(ServerFailure('[Server]: $error'));
      // }
    } else {
      return Left(ConnectionFailure(AppStrings.noInternet));
    }
  }
}