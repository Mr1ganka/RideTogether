import 'package:cloud_firestore/cloud_firestore.dart';                                                                                                                                                                                                                         
    import 'package:flutter_riverpod/flutter_riverpod.dart';                                                                                                                                                                                                                       
    import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';                                                                                                                                                                             
    import 'package:ride_together/features/profile/presentation/providers/profile_repository_provider.dart';                                                                                                                                                                       
    import 'package:ride_together/features/ride/data/datasources/ride_remote_data_source.dart';                                                                                                                                                                                    
    import 'package:ride_together/features/ride/data/repositories/ride_repository_impl.dart';                                                                                                                                                                                      
    import 'package:ride_together/features/ride/domain/entities/ride.dart';                                                                                                                                                                                                        
    import 'package:ride_together/features/ride/domain/repositories/ride_repository.dart';                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                   
    /// Provider for the remote data source handling Firestore operations for Rides.                                                                                                                                                                                               
    ///                                                                                                                                                                                                                                                                            
    /// SPRING BOOT ANALOGY:                                                                                                                                                                                                                                                       
    /// `@Bean public RideRemoteDataSource rideRemoteDataSource()`                                                                                                                                                                                                                 
    final rideRemoteDataSourceProvider = Provider<RideRemoteDataSource>((ref) {                                                                                                                                                                                                    
      return FirebaseRideRemoteDataSource(firestore: FirebaseFirestore.instance);                                                                                                                                                                                                  
    });

    final rideRepositoryProvider = Provider<RideRepository>((ref) {                                                                                                                                                                                                                
      return RideRepositoryImpl(                                                                                                                                                                                                                                                   
        remoteDataSource: ref.watch(rideRemoteDataSourceProvider),                                                                                                                                                                                                                 
        authRepository: ref.watch(authRepositoryProvider),                                                                                                                                                                                                                         
        profileRepository: ref.watch(profileRepositoryProvider),                                                                                                                                                                                                                   
      );                                                                                                                                                                                                                                                                           
    });

    final activeRideProvider = StreamProvider<Ride?>((ref) {
  try {
    final repository = ref.watch(rideRepositoryProvider);
    return repository.watchActiveRide();
  } catch (_) {
    return Stream.value(null);
  }
});

    