#!/bin/bash

# Set default values for variables
attack_type="cpu"
duration=60

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	  key="$1"
	    case $key in
		        -t|--type)
				      attack_type="$2"
				            shift
					          shift
						        ;;
							    -d|--duration)
								          duration="$2"
									        shift
										      shift
										            ;;
											        *)
													      shift
													            ;;
														      esac
													      done

													      # Print attack details
													      echo "Starting resource attack: $attack_type for $duration seconds"

													      # Launch the specified resource attack
													      case $attack_type in
														        cpu)
																    # Consume 100% of CPU
																        while [ $duration -gt 0 ]; do
																		      :
																		            duration=$((duration-1))
																			          sleep 1
																				      done
																				          ;;
																					    memory)
																						        # Consume all available memory
																							    while [ $duration -gt 0 ]; do
																								          dd if=/dev/zero of=/dev/null bs=1M
																									        duration=$((duration-1))
																										      sleep 1
																										          done
																											      ;;
																											        disk)
																													    # Consume all available disk space
																													        while [ $duration -gt 0 ]; do
																															      dd if=/dev/zero of=temp.dat bs=1M
																															            duration=$((duration-1))
																																          sleep 1
																																	      done
																																	          rm temp.dat
																																		      ;;
																																		        network)
																																				    # Consume all available network bandwidth
																																				        while [ $duration -gt 0 ]; do
																																						      dd if=/dev/zero | nc -w 1 localhost 8080
																																						            duration=$((duration-1))
																																							          sleep 1
																																								      done
																																								          ;;
																																									    *)
																																										        echo "Invalid attack type: $attack_type"
																																											    exit 1
																																											        ;;
																																										esac

																																										echo "Finished resource attack"

